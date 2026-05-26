import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IpAddressInput extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final String hintText;
  final String? initialValue;

  const IpAddressInput({
    required this.onCompleted,
    this.hintText = '10.0.0.1',
    this.initialValue,
    super.key,
  });

  @override
  State<IpAddressInput> createState() => _IpAddressInputState();
}

class _IpAddressInputState extends State<IpAddressInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleKeyPress(String value) {
    HapticFeedback.lightImpact();
    final currentText = _controller.text;

    if (value == 'BACKSPACE') {
      if (currentText.isNotEmpty) {
        setState(() {
          _controller.text = currentText.substring(0, currentText.length - 1);
        });
        widget.onCompleted(_controller.text);
      }
      return;
    }

    final segments = currentText.split('.');
    final lastSegment = segments.last;

    if (value == '.') {
      // Prevent starting with a dot, double dots, or exceeding 3 dots (4 octets)
      if (currentText.isNotEmpty && !currentText.endsWith('.') && segments.length < 4) {
        setState(() {
          _controller.text = '$currentText.';
        });
        widget.onCompleted(_controller.text);
      }
    } else {
      // It is a digit
      if (lastSegment.length == 3) {
        // Auto-insert dot and start the next octet if we have room
        if (segments.length < 4) {
          setState(() {
            _controller.text = '$currentText.$value';
          });
          widget.onCompleted(_controller.text);
        }
      } else {
        final newLastSegment = lastSegment + value;
        final val = int.tryParse(newLastSegment);
        if (val != null && val <= 255) {
          setState(() {
            _controller.text = currentText + value;
          });
          widget.onCompleted(_controller.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // IP Address Text Field (Read-only to suppress system keyboard)
        TextFormField(
          controller: _controller,
          readOnly: true,
          showCursor: true,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.dns_outlined),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      setState(() {
                        _controller.clear();
                      });
                      widget.onCompleted('');
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Custom Numeric Keypad Container
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quick-link button for ExpressLRS Access Point mode IP
              InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  setState(() {
                    _controller.text = '10.0.0.1';
                  });
                  widget.onCompleted('10.0.0.1');
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wifi_tethering, size: 16, color: theme.colorScheme.secondary),
                      const SizedBox(width: 8),
                      Text(
                        'AP MODE (10.0.0.1)',
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 12),
              
              // Keypad Grid
              _buildKeyboardGrid(theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeyboardGrid(ThemeData theme) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final double buttonHeight = isLandscape ? 44.0 : 54.0;

    Widget buildRow(List<Widget> children) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: children.map((child) => Expanded(child: child)).toList(),
        ),
      );
    }

    Widget makeButton(String label, {bool isBackspace = false, bool isAction = false}) {
      return SizedBox(
        height: buttonHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _buildKey(label, theme, isBackspace: isBackspace, isAction: isAction),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildRow([
          makeButton('1'),
          makeButton('2'),
          makeButton('3'),
        ]),
        buildRow([
          makeButton('4'),
          makeButton('5'),
          makeButton('6'),
        ]),
        buildRow([
          makeButton('7'),
          makeButton('8'),
          makeButton('9'),
        ]),
        buildRow([
          makeButton('.', isAction: true),
          makeButton('0'),
          makeButton('⌫', isBackspace: true),
        ]),
      ],
    );
  }

  Widget _buildKey(
    String label,
    ThemeData theme, {
    bool isBackspace = false,
    bool isAction = false,
  }) {
    // Modern color choices for keys based on theme and action type
    final Color keyColor = isBackspace
        ? theme.colorScheme.errorContainer.withValues(alpha: 0.3)
        : (isAction
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.5)
            : theme.colorScheme.surfaceContainerLow);

    final Color textColor = isBackspace
        ? theme.colorScheme.onErrorContainer
        : (isAction ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface);

    return Material(
      color: keyColor,
      borderRadius: BorderRadius.circular(12),
      elevation: 0.5,
      child: InkWell(
        onTap: () => _handleKeyPress(isBackspace ? 'BACKSPACE' : label),
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: isBackspace
              ? Icon(Icons.backspace_outlined, size: 22, color: textColor)
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }
}
