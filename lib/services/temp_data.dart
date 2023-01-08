import 'package:cinenexa/models/network/extensions/extension.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';

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
    )..icon =
        "https://pbs.twimg.com/profile_images/768615067608768512/xn4YILrz_400x400.jpg",
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
    )..icon =
        "https://bucketeer-d402f3d7-4567-4b00-b26c-5f2a1706bc6c.s3.amazonaws.com/public/pictures/soap-2-day.jpg?VersionId=7bfnr6k6QwciKzIAC4oEN2PxeBkhhe.J",
  ];

  static final List<ExtensionStream> streams = [
    ExtensionStream.url(
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      country: "US|FR",
      quality: "720",
      seeds: 130,
    )..extension = TempData().extensions[0],
    ExtensionStream.external(
      dubbed: true,
      name: "TOrrent stream 240p",
      quality: "720",
      size: 40000,
      seeds: 130,
      external: 'https://www.google.com',
    )..extension = TempData().extensions[0],
    ExtensionStream.url(
      url: "url",
      dubbed: true,
      name: "TOrrent stream 240p",
      country: "US|FR|AM",
      quality: "720",
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
      country: "US|FR|AM",
      quality: "720",
      seeds: 130,
    )..extension = TempData().extensions[1],
  ];
}
