import '../models/network/base_model.dart';
import '../resources/strings.dart';
import '../store/details/details_store.dart';

class ProgressUtils {
  static String getPlayText(DetailsStore detailsStore) {
    if (detailsStore.progress != null) {
      String text = Strings.resume;
      if (detailsStore.baseModel.type == BaseModelType.tv &&
          detailsStore.progress?.seasonNo != null &&
          detailsStore.progress?.episodeNo != null) {
        text +=
            " S${detailsStore.progress!.seasonNo!} EP${detailsStore.progress!.episodeNo!}";
      }
      return text;
    }
    if (detailsStore.showHistory != null) {
      return "${Strings.play} S${detailsStore.showHistory!.lastWatchedSeason!} EP${detailsStore.showHistory!.lastWatched!.number}";
    }
    return Strings.play;
  }
}
