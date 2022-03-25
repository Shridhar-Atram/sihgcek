class Language {
  final int id;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1,  "English", "en"),
      Language(2,  "Hindi", "hi"),
      Language(3,  "Marathi", "mr"),
      Language(4,  "Tamil", "ta"),
      Language(4,  "Punjabi", "pa"),
    ];
  }

  static List<Language> langs = [
    Language(1,  "English", "en"),
    Language(2,  "Hindi", "hi"),
    Language(3,  "Marathi", "mr"),
    Language(4,  "Tamil", "ta"),
    Language(4,  "Punjabi", "pa"),
  ];
}
