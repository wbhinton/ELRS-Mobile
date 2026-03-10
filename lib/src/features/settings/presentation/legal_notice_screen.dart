import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalNoticeScreen extends StatelessWidget {
  const LegalNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legal & License')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Legal Notice',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'ELRS Mobile is a free and open-source (FOSS) project developed independently by Weston Hinton. '
            'This project is not an official product of ExpressLRS LLC and is not officially supported, endorsed, or certified by the ExpressLRS development team.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            'Trademark Notice',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'ExpressLRS and the ExpressLRS logo are trademarks of ExpressLRS LLC. Use of these marks is for descriptive and compatibility purposes only. '
            'For the official ExpressLRS configurator and documentation, please visit expresslrs.org.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            'Official Support',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Support the official ExpressLRS project: ',
            style: TextStyle(fontSize: 16),
          ),
          InkWell(
            onTap: () => _launchUrl(
              'https://opencollective.com/expresslrs/donate?interval=oneTime&amount=20&name=&legalName=&email=',
            ),
            child: const Text(
              'Donate via Open Collective',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 24),
          Divider(),
          SizedBox(height: 24),
          Text(
            'Software License',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'This project is licensed under the GNU General Public License v3.0.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16),
          _GPLText(),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _GPLText extends StatelessWidget {
  const _GPLText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '                    GNU GENERAL PUBLIC LICENSE\n'
      '                       Version 3, 29 June 2007\n'
      '\n'
      ' Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>\n'
      ' Everyone is permitted to copy and distribute verbatim copies\n'
      ' of this license document, but changing it is not allowed.\n'
      '\n'
      '                            Preamble\n'
      '\n'
      '  The GNU General Public License is a free, copyleft license for\n'
      'software and other kinds of works.\n'
      '...\n'
      '[Full license text abbreviated for brevity in UI, referring to LICENSE file or providing scrollable view]',
      style: TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}
