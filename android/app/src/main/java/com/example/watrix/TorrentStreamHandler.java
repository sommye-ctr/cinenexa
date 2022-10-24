package com.example.watrix;

import io.flutter.plugin.common.EventChannel;

public class TorrentStream {
    private String streamUrl;
    private EventChannel.EventSink eventSink;

    public TorrentStream(String streamUrl, EventChannel.EventSink eventSink) {
        this.streamUrl = streamUrl;
        this.eventSink = eventSink;

        startStream();
    }

    private void startStream() {

    }


}
