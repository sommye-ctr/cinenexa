enum ExtensionProviderType {
  movie,
  show,
  anime,
  documentary,
  all,
}

extension ExtensionProviderConverter on ExtensionProviderType {
  String getString() {
    switch (this) {
      case ExtensionProviderType.all:
        return "all";
      case ExtensionProviderType.movie:
        return "movie";
      case ExtensionProviderType.show:
        return "show";
      case ExtensionProviderType.anime:
        return "anime";
      case ExtensionProviderType.documentary:
        return "documentary";
      default:
        throw UnimplementedError("Invalid provider type");
    }
  }
}

extension StringConverter on String {
  ExtensionProviderType getProviderType() {
    switch (this) {
      case "movie":
        return ExtensionProviderType.movie;
      case "show":
        return ExtensionProviderType.show;
      case "anime":
        return ExtensionProviderType.anime;
      case "documentary":
        return ExtensionProviderType.documentary;
      case "all":
        return ExtensionProviderType.all;
      default:
        throw UnimplementedError("Invalid provider type");
    }
  }
}
