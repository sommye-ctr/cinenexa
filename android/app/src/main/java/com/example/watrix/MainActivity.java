package com.example.watrix;

import android.content.Intent;
import android.util.Log;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import java.util.Map;

public class MainActivity
  extends FlutterActivity
  implements EventChannel.StreamHandler {

  private static final String TORRENT_STREAM_EVENT_NAME =
    "watrix/torrentStream";

  private TorrentStreamHandler torrentStreamHandler;

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    startService(new Intent(this, NotificationService.class));
    new EventChannel(
      flutterEngine.getDartExecutor().getBinaryMessenger(),
      TORRENT_STREAM_EVENT_NAME
    )
      .setStreamHandler(this);
  }

  @Override
  protected void onDestroy() {
    if (torrentStreamHandler != null) {
      torrentStreamHandler.stopStream();
    }
    super.onDestroy();
  }

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    Map<String, Object> map = ((Map<String, Object>) arguments);
    String url = (String) map.get("url");
    int index = -1;
    if (map.containsKey("index") && map.get("index") != null) {
      index = Integer.parseInt(String.valueOf(map.get("index")));
    }
    torrentStreamHandler =
      new TorrentStreamHandler(url, index, events, getFilesDir(), this);
  }

  @Override
  public void onCancel(Object arguments) {
    torrentStreamHandler.stopStream();
  }
}
