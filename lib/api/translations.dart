class Translations{


  static final Map<String, String> language_map = {


      "انگلیسی" : "English",
      "اسپانیایی" : "Spanish",
      "فرانسوی" : "French",
      "آلمانی": "German",
      "ایتالیایی" : "Italian",
      "روسی" : "Russian",
      "فارسی" : "Persian",

  };


  static final language_latin = <String>[

    "English",
    "Spanish",
    "French",
    "German",
    "Italian",
    "Russian",
    "Persian",


  ];



  static String getlangugageCode(String language){

    switch(language){

      case 'English':
        return 'en';
      case 'Persian':
        return 'fa';
      case 'French':
        return 'fr';
      case 'Italian':
        return 'it';
      case 'Russian':
        return 'ru';
      case 'Spanish':
        return 'es';
      case 'German':
        return 'de';
      default:
        return 'en';
    }
  }


}