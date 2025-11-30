String LanguageConverter({required String languageCode}) {
  switch (languageCode) {
    case 'ar':
      return 'Arabic';
    case 'de':
      return 'German';  
    case 'en':
      return 'English';
    case 'fr':
      return 'French';
    case 'hi':
      return 'Hindi';
    case 'it':
      return 'Italian';
    case 'ja':
      return 'Japanese';
    case 'ko':
      return 'Korean';
    case 'ru':
      return 'Russian';
    case 'uk':
      return 'Ukrainian';              
    case 'vi':
      return 'Vietnamese';
    case 'zh':
      return 'Chinese';
    
    default:
      return 'Unknown';
  }
}
