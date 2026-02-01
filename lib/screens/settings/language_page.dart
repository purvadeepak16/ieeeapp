import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = 'English (UK)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, selectedLanguage),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Suggested'),
          _radio('English (US)'),
          _radio('English (UK)'),
          _title('Others'),
          _radio('Hindi'),
        ],
      ),
    );
  }

  Widget _radio(String value) => RadioListTile<String>(
    title: Text(value),
    value: value,
    groupValue: selectedLanguage,
    onChanged: (v) => setState(() => selectedLanguage = v!),
  );

  Widget _title(String text) => Padding(
    padding: const EdgeInsets.all(16),
    child:
    Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
