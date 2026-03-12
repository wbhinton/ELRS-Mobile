import 'package:flutter/material.dart';
import '../../../../core/presentation/responsive_layout.dart';

enum SettingsCategory { flashing, about, advanced }

class SettingsMasterDetail extends StatefulWidget {
  const SettingsMasterDetail({
    super.key,
    required this.masterBuilder,
    required this.detailBuilder,
  });

  final Widget Function(
    BuildContext context,
    SettingsCategory selected,
    ValueChanged<SettingsCategory> onSelected,
  )
  masterBuilder;
  final Widget Function(BuildContext context, SettingsCategory selected)
  detailBuilder;

  @override
  State<SettingsMasterDetail> createState() => _SettingsMasterDetailState();
}

class _SettingsMasterDetailState extends State<SettingsMasterDetail> {
  SettingsCategory _selectedCategory = SettingsCategory.flashing;

  @override
  Widget build(BuildContext context) {
    if (!ResponsiveLayout.isTablet(context)) {
      // Mobile sees everything as one list
      return widget.detailBuilder(context, SettingsCategory.flashing);
    }

    return Row(
      children: [
        // Master Pane (Sidebar)
        SizedBox(
          width: 250,
          child: Material(
            elevation: 1,
            child: widget.masterBuilder(
              context,
              _selectedCategory,
              (category) => setState(() => _selectedCategory = category),
            ),
          ),
        ),
        // Divider
        const VerticalDivider(width: 1),
        // Detail Pane
        Expanded(child: widget.detailBuilder(context, _selectedCategory)),
      ],
    );
  }
}
