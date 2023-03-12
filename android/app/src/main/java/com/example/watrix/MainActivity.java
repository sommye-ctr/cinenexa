package com.example.watrix;

import com.google.android.gms.cast.framework.CastContext;
import android.content.Intent;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.Map;

public class MainActivity
  extends FlutterFragmentActivity
  implements MethodChannel.MethodCallHandler {

  private static final String TORRENT_STREAM_EVENT_NAME =
    "cinenexa/torrentStream";

  private TorrentStreamHandler torrentStreamHandler;
  private MethodChannel methodChannel;

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);

    CastContext.getSharedInstance(getApplicationContext());
    startService(new Intent(this, NotificationService.class));

    methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), TORRENT_STREAM_EVENT_NAME);
   methodChannel.setMethodCallHandler(this);
  }

  @Override
  protected void onDestroy() {
    if (torrentStreamHandler != null) {
      torrentStreamHandler.stopStream();
    }
    super.onDestroy();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    if (call.method.equals("start")){
      Map<String, Object> map = call.arguments();
      String url = null;
      if (map != null) {
        url = (String) map.get("url");
      }
      int index = -1;
      if (map != null && map.containsKey("index") && map.get("index") != null) {
        index = Integer.parseInt(String.valueOf(map.get("index")));
      }
      torrentStreamHandler =
              new TorrentStreamHandler(url, index,methodChannel, getFilesDir(), this);
    } else if (call.method.equals("stop")){
      torrentStreamHandler.stopStream();
    }
  }
}
