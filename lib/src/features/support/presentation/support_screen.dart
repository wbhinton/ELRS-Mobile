import 'package:flutter/material.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../settings/presentation/disclaimer_dialog.dart';

class SupportScreen extends HookConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 3);
    useListenable(tabController);
    final l10n = AppLocalizations.of(context)!;

    Future<String> loadFaqContent() async {
      final locale = Localizations.localeOf(context).languageCode;
      final localizedPath = 'assets/docs/app_faq_$locale.md';
      try {
        return await DefaultAssetBundle.of(context).loadString(localizedPath);
      } catch (_) {
        return await DefaultAssetBundle.of(context).loadString('assets/docs/app_faq.md');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.helpSupportLabel),
      ),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: useMemoized(
            loadFaqContent,
            [Localizations.localeOf(context).languageCode],
          ),
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

            final tabViews = [
              _SupportContentList(
                sections: walkthroughSteps,
                initialOpen: 0,
              ),
              _SupportContentList(
                sections: faqItems,
              ),
              _ResourcesTab(ref: ref),
            ];

            return OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  return Row(
                    children: [
                      NavigationRail(
                        selectedIndex: tabController.index,
                        onDestinationSelected: (int index) {
                          tabController.animateTo(index);
                        },
                        labelType: NavigationRailLabelType.all,
                        destinations: [
                          NavigationRailDestination(
                            icon: const Icon(Icons.menu_book_outlined),
                            selectedIcon: const Icon(Icons.menu_book),
                            label: Text(l10n.tabFlashingGuide),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.question_answer_outlined),
                            selectedIcon: const Icon(Icons.question_answer),
                            label: Text(l10n.tabFaq),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.public_outlined),
                            selectedIcon: const Icon(Icons.public),
                            label: Text(l10n.tabResources),
                          ),
                        ],
                      ),
                      const VerticalDivider(thickness: 1, width: 1),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: tabViews,
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    TabBar(
                      controller: tabController,
                      isScrollable: true,
                      tabs: [
                        Tab(text: l10n.tabFlashingGuide),
                        Tab(text: l10n.tabFaq),
                        Tab(text: l10n.tabResources),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: tabViews,
                      ),
                    ),
                  ],
                );
              },
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
    final l10n = AppLocalizations.of(context)!;
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
                  title: Text(l10n.resourceCommunitySupport, style: titleStyle),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    title: Text(l10n.resourceDiscordCommunity),
                    subtitle: Text(l10n.resourceJoinDiscord),
                    leading: const Icon(Icons.chat),
                    onTap: () => _launchUrl('https://discord.gg/expresslrs'),
                  ),
                  ListTile(
                    title: Text(l10n.resourceGithubRepo),
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
                  title: Text(l10n.resourceFlashRecovery, style: titleStyle),
                );
              },
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.resourceDeviceUnresponsiveInfo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _RecoveryStep(
                      number: '1',
                      text: l10n.resourceRecoveryStep1,
                    ),
                    _RecoveryStep(
                      number: '2',
                      text: l10n.resourceRecoveryStep2,
                    ),
                    _RecoveryStep(
                      number: '3',
                      text: l10n.resourceRecoveryStep3,
                    ),
                    _RecoveryStep(
                      number: '4',
                      text: l10n.resourceRecoveryStep4,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.resourceBardwellGuideRecommended,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton.icon(
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: Text(l10n.resourceWebFlasherButton),
                          onPressed: () => _launchUrl('https://expresslrs.github.io/web-flasher/'),
                        ),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.play_circle_outline, size: 16),
                          label: Text(l10n.resourceRecoveryVideoButton),
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
                  title: Text(l10n.resourceLegalLiability, style: titleStyle),
                );
              },
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
                  children: [
                    Text(
                      l10n.resourceLiabilityDisclaimerText,
                      style: const TextStyle(height: 1.5),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: Text(l10n.resourceViewFullDisclaimerButton),
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
