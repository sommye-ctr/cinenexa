import 'package:watrix/models/network/extensions/extension.dart';
import 'package:watrix/models/network/extensions/extension_stream.dart';

class TempData {
  final extensions = [
    Extension(
      name: "FMovies",
      id: "com.fmovies",
      endpoint: "",
      providesMovie: true,
      providesAnime: false,
      providesShow: true,
      description:
          "Find movies and shows for all hollywood and bollywood titles.",
      createdAt: DateTime.now(),
      domainId: "",
    ),
    Extension(
      name: "Soap2day",
      id: "com.soap2day",
      endpoint: "",
      providesMovie: true,
      providesAnime: false,
      providesShow: true,
      description:
          "Find movies and shows for all hollywood and bollywood titles.",
      createdAt: DateTime.now(),
      domainId: "",
    ),
  ];

  static final List<ExtensionStream> streams = [
    ExtensionStream.url(
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      langCountry: "US|FR",
      quality: 720,
      seeds: 130,
    )..extension = TempData().extensions[0],
    ExtensionStream.externalUrl(
      dubbed: true,
      name: "TOrrent stream 240p",
      quality: 720,
      size: 40000,
      seeds: 130,
      externalUrl: 'https://www.google.com',
    )..extension = TempData().extensions[0],
    ExtensionStream.url(
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      langCountry: "US|FR|AM",
      quality: 720,
      size: 40000,
      seeds: 130,
    )..extension = TempData().extensions[0],
    ExtensionStream.url(
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
    )..extension = TempData().extensions[1],
    ExtensionStream.url(
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      size: 40000,
      seeds: 130,
    )..extension = TempData().extensions[1],
    ExtensionStream.url(
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      langCountry: "US|FR|AM",
      quality: 720,
      seeds: 130,
    )..extension = TempData().extensions[1],
  ];
}
