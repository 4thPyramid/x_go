import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = 'English'; // اللغة الافتراضية

  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en', 'flag': '🇺🇸'},
    {'name': 'العربية', 'code': 'ar', 'flag': '🇸🇦'},
    {'name': 'Русский', 'code': 'ru', 'flag': '🇷🇺'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = selectedLanguage == language['name'];
          
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                ),
                child: Center(
                  child: Text(
                    language['flag']!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              title: Text(
                language['name']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.blue : Colors.black,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.blue)
                  : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
              onTap: () {
                setState(() {
                  selectedLanguage = language['name']!;
                });
                
                // يمكنك إضافة منطق حفظ اللغة هنا
                _saveLanguagePreference(language['code']!);
                
                // عرض رسالة تأكيد
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Language changed to ${language['name']}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _saveLanguagePreference(String languageCode) {
    // هنا يمكنك حفظ اللغة في SharedPreferences أو أي طريقة تخزين أخرى
    print('Saving language: $languageCode');
    // SharedPreferences.getInstance().then((prefs) {
    //   prefs.setString('selected_language', languageCode);
    // });
  }
}