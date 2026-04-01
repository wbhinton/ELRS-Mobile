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
              Tab(text: 'Flashing Guide'),
              Tab(text: 'FAQ'),
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
                _SupportContentList(
                  sections: walkthroughSteps,
                  initialOpen: 0,
                ),
                _SupportContentList(
                  sections: faqItems,
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
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionPanelList.radio(
          elevation: 2,
          children: [
            ExpansionPanelRadio(
              value: 0,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  leading: Icon(
                    Icons.chat_bubble_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text('Community & Support', style: titleStyle),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    title: const Text('Discord Community'),
                    subtitle: const Text('Join the ELRS Discord'),
                    leading: const Icon(Icons.chat),
                    onTap: () => _launchUrl('https://discord.gg/expresslrs'),
                  ),
                  ListTile(
                    title: const Text('GitHub Repository'),
                    subtitle: const Text('https://github.com/wbhinton/ELRS-Mobile'),
                    leading: const Icon(Icons.code),
                    onTap: () => _launchUrl('https://github.com/wbhinton/ELRS-Mobile'),
                  ),
                ],
              ),
            ),
            ExpansionPanelRadio(
              value: 1,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  leading: const Icon(
                    Icons.build_circle_outlined,
                    color: Colors.orange,
                  ),
                  title: Text('Flash Recovery', style: titleStyle),
                );
              },
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'If your device appears unresponsive after a failed flash:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
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
                      text: 'For WiFi-capable devices, hold BOOT for 60 seconds to trigger WiFi Hotspot recovery mode.',
                    ),
                    const _RecoveryStep(
                      number: '4',
                      text: 'Join #help on the ELRS Discord — the community can usually recover any device.',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Joshua Bardwell\'s unbricking guide is highly recommended:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton.icon(
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const Text('Web Flasher'),
                          onPressed: () => _launchUrl('https://expresslrs.github.io/web-flasher/'),
                        ),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.play_circle_outline, size: 16),
                          label: const Text('Recovery Video'),
                          onPressed: () => _launchUrl('https://www.youtube.com/watch?v=TzAaYg47TSU'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ExpansionPanelRadio(
              value: 2,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  leading: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.amber,
                  ),
                  title: Text('Legal & Liability', style: titleStyle),
                );
              },
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
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
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: const Text('View Full Disclaimer'),
                        onPressed: () => showDisclaimerDialog(context, ref, barrierDismissible: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportContentList extends StatelessWidget {
  final List<Map<String, String>> sections;
  final int? initialOpen;

  const _SupportContentList({
    required this.sections,
    this.initialOpen,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionPanelList.radio(
          initialOpenPanelValue: initialOpen,
          elevation: 2,
          children: sections.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return ExpansionPanelRadio(
              value: index,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(
                    item['title']!,
                    style: titleStyle,
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: MarkdownBody(
                  data: item['body']!,
                  onTapLink: (text, href, title) {
                    if (href != null) _launchUrl(href);
                  },
                ),
              ),
            );
          }).toList(),
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
