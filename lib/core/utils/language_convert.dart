String LanguageConverter({required String languageCode}) {
  switch (languageCode) {
    case 'ar':
      return 'Arabic-العربية';
    case 'de':
      return 'German - Deutsch';  
    case 'en':
      return 'English - American English';
    case 'fr':
      return 'French - Français';
    case 'hi':
      return 'Hindi - हिंदी';
    case 'it':
      return 'Italian - Italiano';
    case 'ja':
      return 'Japanese - 日本語';
    case 'ko':
      return 'Korean - 한국어';
    case 'ru':
      return 'Russian - Русский';
    case 'uk':
      return 'Ukrainian - Українська';              
    case 'vi':
      return 'Vietnamese - Tiếng Việt';
    case 'zh':
      return 'Chinese - 中文';
    
    default:
      return 'Unknown';
  }
}
