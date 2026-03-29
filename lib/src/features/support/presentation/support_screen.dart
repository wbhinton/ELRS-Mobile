import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../settings/presentation/disclaimer_dialog.dart';

class SupportScreen extends HookConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help & Support'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'FAQ'),
              Tab(text: 'Walkthrough'),
              Tab(text: 'Resources'),
            ],
          ),
        ),
        body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/docs/app_faq.md'),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error loading help content: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final content = snapshot.data!;
            final mainParts = content.split('---');
            final walkthroughRaw = mainParts.isNotEmpty ? mainParts[0] : '';
            final faqRaw = mainParts.length > 1 ? mainParts[1] : '';

            List<Map<String, String>> parseSections(String rawText) {
              final sections = <Map<String, String>>[];
              final chunks = rawText.split('## ');
              for (int i = 1; i < chunks.length; i++) {
                final lines = chunks[i].split('\n');
                final title = lines.first.trim();
                final body = lines.sublist(1).join('\n').trim();
                sections.add({'title': title, 'body': body});
              }
              return sections;
            }

            final walkthroughSteps = parseSections(walkthroughRaw);
            final faqItems = parseSections(faqRaw);

            return TabBarView(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: faqItems.length,
                  itemBuilder: (context, index) {
                    final item = faqItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: ExpansionTile(
                        title: Text(
                          item['title']!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        childrenPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarkdownBody(
                            data: item['body']!,
                            onTapLink: (text, href, title) {
                              if (href != null) _launchUrl(href);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: walkthroughSteps.length,
                  itemBuilder: (context, index) {
                    final step = walkthroughSteps[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: ExpansionTile(
                        initiallyExpanded: index == 0, // Auto-expand the first step
                        title: Text(
                          step['title']!,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        childrenPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarkdownBody(
                            data: step['body']!,
                            onTapLink: (text, href, title) {
                              if (href != null) _launchUrl(href);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _ResourcesTab(ref: ref),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ResourcesTab extends StatelessWidget {
  final WidgetRef ref;
  const _ResourcesTab({required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const _SectionHeader(title: 'Community'),
        ListTile(
          title: const Text('GitHub Repository'),
          subtitle: const Text('https://github.com/wbhinton/ELRS-Mobile'),
          leading: const Icon(Icons.code),
          onTap: () => _launchUrl('https://github.com/wbhinton/ELRS-Mobile'),
        ),
        ListTile(
          title: const Text('Discord Community'),
          subtitle: const Text('Join the ELRS Discord'),
          leading: const Icon(Icons.chat),
          onTap: () => _launchUrl('https://discord.gg/expresslrs'),
        ),
        const Divider(),
        const _SectionHeader(title: 'Legal & Recovery'),
        ExpansionTile(
          leading: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.amber,
          ),
          title: const Text('Disclaimer & Liability'),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            const Text(
              'ELRS Mobile is provided as-is, without warranty of any kind. '
              'The developers are not responsible for any damage, data loss, or '
              'non-functional hardware resulting from the use of this application, '
              'including but not limited to bricked receivers, transmitters, or '
              'flight controllers.\n\n'
              'By using this app you accept full responsibility for your hardware.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('View Full Disclaimer'),
                onPressed: () => showDisclaimerDialog(
                  context,
                  ref,
                  barrierDismissible: true,
                ),
              ),
            ),
          ],
        ),
        ExpansionTile(
          leading: const Icon(
            Icons.build_circle_outlined,
            color: Colors.orange,
          ),
          title: const Text('Flash Recovery Instructions'),
          subtitle: const Text('What to do if a flash fails'),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            const Text(
              'If your device appears unresponsive after a failed flash:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const _RecoveryStep(
              number: '1',
              text: 'Hold the BOOT button while plugging in via USB to enter bootloader mode.',
            ),
            const _RecoveryStep(
              number: '2',
              text: 'Use the ELRS Web Flasher at expresslrs.org/flasher to re-flash over USB/UART.',
            ),
            const _RecoveryStep(
              number: '3',
              text: 'For WiFi-capable devices, hold BOOT for 60 s to trigger WiFi Hotspot recovery mode.',
            ),
            const _RecoveryStep(
              number: '4',
              text: 'Join #help on the ELRS Discord — the community can usually recover any device.',
            ),
            const SizedBox(height: 12),
            const Text(
              'Joshua Bardwell\'s "The easiest way to unbrick an ELRS receiver" video is highly recommended:',
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Web Flasher'),
                  onPressed: () => _launchUrl(
                    'https://expresslrs.github.io/web-flasher/',
                  ),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.play_circle_outline, size: 16),
                  label: const Text('Recovery Video'),
                  onPressed: () => _launchUrl(
                    'https://www.youtube.com/watch?v=TzAaYg47TSU',
                  ),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.chat, size: 16),
                  label: const Text('Discord'),
                  onPressed: () => _launchUrl('https://discord.gg/expresslrs'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _RecoveryStep extends StatelessWidget {
  const _RecoveryStep({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(height: 1.4))),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
