enum Languages {
  en,
  de,
  ja,
  hi,
  ta,
  bn,
  fr,
  es, //spanish
  ru,

  pt, //portugese

  ar,

  id,
}

extension LanguageConverter on String {
  Languages getLanguage() {
    if (this == Languages.en.getName()) {
      return Languages.en;
    } else if (this == Languages.hi.getName()) {
      return Languages.hi;
    } else if (this == Languages.fr.getName()) {
      return Languages.fr;
    } else if (this == Languages.es.getName()) {
      return Languages.es;
    } else if (this == Languages.ru.getName()) {
      return Languages.ru;
    } else if (this == Languages.ta.getName()) {
      return Languages.ta;
    } else if (this == Languages.pt.getName()) {
      return Languages.pt;
    } else if (this == Languages.de.getName()) {
      return Languages.de;
    } else if (this == Languages.ja.getName()) {
      return Languages.ja;
    } else if (this == Languages.ar.getName()) {
      return Languages.ar;
    } else if (this == Languages.id.getName()) {
      return Languages.id;
    } else if (this == Languages.bn.getName()) {
      return Languages.bn;
    } else {
      throw UnimplementedError();
    }
  }
}

extension Language on Languages {
  String getName() {
    switch (this) {
      case Languages.en:
        return "English";
      case Languages.hi:
        return "Hindi";
      case Languages.fr:
        return "French";
      case Languages.es:
        return "Spanish";
      case Languages.ru:
        return "Russian";
      case Languages.ta:
        return "Tamil";
      case Languages.pt:
        return "Portugese";
      case Languages.de:
        return "German";
      case Languages.ja:
        return "Japanese";
      case Languages.ar:
        return "Arabic";
      case Languages.bn:
        return "Bengali";
      case Languages.id:
        return "Indonesian";
    }
  }
}
