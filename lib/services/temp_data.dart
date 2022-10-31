import 'package:watrix/models/network/enums/extension_provider_type.dart';
import 'package:watrix/models/network/extensions/extension.dart';
import 'package:watrix/models/network/extensions/extension_stream.dart';

class TempData {
  final extensions = [
    Extension(
      name: "FMovies",
      id: "com.fmovies",
      icon:
          "https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/14-utorrent-512.png",
      endpoint: "",
      provider: ExtensionProviderType.all,
    ),
    Extension(
      name: "Soap2day",
      id: "com.soap2day",
      icon:
          "https://i.pinimg.com/736x/97/39/af/9739afdcd7bea0686f7396182c85bea1.jpg",
      endpoint: "",
      provider: ExtensionProviderType.movie,
    ),
  ];

  static final List<ExtensionStream> streams = [
    ExtensionStream.url(
      id: 48843932827,
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      langCountry: "US|FR",
      quality: 720,
      seeds: 130,
    )..extension = TempData().extensions[0],
    ExtensionStream.url(
      id: 48843932827,
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      quality: 720,
      size: 40000,
      seeds: 130,
    )..extension = TempData().extensions[0],
    ExtensionStream.url(
      id: 48843932827,
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      langCountry: "US|FR|AM",
      quality: 720,
      size: 40000,
      seeds: 130,
    )..extension = TempData().extensions[0],
    ExtensionStream.url(
      id: 48843932827,
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
    )..extension = TempData().extensions[1],
    ExtensionStream.url(
      id: 48843932827,
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      size: 40000,
      seeds: 130,
    )..extension = TempData().extensions[1],
    ExtensionStream.url(
      id: 48843932827,
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      langCountry: "US|FR|AM",
      quality: 720,
      seeds: 130,
    )..extension = TempData().extensions[1],
  ];
}
