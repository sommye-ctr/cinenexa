package com.example.watrix;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;

public class MainActivity extends FlutterActivity implements EventChannel.StreamHandler {

    private static final String TORRENT_STREAM_EVENT_NAME = "watrix/torrentStream";

     private TorrentStreamHandler torrentStreamHandler;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), TORRENT_STREAM_EVENT_NAME)
                .setStreamHandler(this);
    }

    @Override
    protected void onDestroy() {
        torrentStreamHandler.stopStream();
        super.onDestroy();
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        torrentStreamHandler = new TorrentStreamHandler((String) ((Map<String, Object>)arguments).get("url"), events, getFilesDir(), this);
    }

    @Override
    public void onCancel(Object arguments) {
        torrentStreamHandler.stopStream();
    }
}
