package com.example.watrix;

import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.util.Log;

import com.github.se_bastiaan.torrentstream.StreamStatus;
import com.github.se_bastiaan.torrentstream.Torrent;
import com.github.se_bastiaan.torrentstream.TorrentOptions;
import com.github.se_bastiaan.torrentstreamserver.TorrentServerListener;
import com.github.se_bastiaan.torrentstreamserver.TorrentStreamNotInitializedException;
import com.github.se_bastiaan.torrentstreamserver.TorrentStreamServer;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import io.flutter.plugin.common.EventChannel;

public class TorrentStreamHandler implements TorrentServerListener {
    private static final String TAG = "Torrent";

    private final String streamUrl;
    private final EventChannel.EventSink eventSink;
    private final File fileDir;
    private final Context context;

    private TorrentStreamServer torrentStreamServer;

    public TorrentStreamHandler(String streamUrl, EventChannel.EventSink eventSink, File fileDir, Context context) {
        this.streamUrl = streamUrl;
        this.eventSink = eventSink;
        this.fileDir = fileDir;
        this.context = context;

        startStream();
    }

    public void stopStream(){
        torrentStreamServer.stopStream();
    }

    private void startStream() {
        TorrentOptions torrentOptions = new TorrentOptions.Builder()
                .saveLocation(fileDir)
                .removeFilesAfterStop(true)
                .build();

        String ipAddress = "127.0.0.1";
        try {
            InetAddress inetAddress = getIpAddress(context);
            if (inetAddress != null) {
                ipAddress = inetAddress.getHostAddress();
            }
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }

        torrentStreamServer = TorrentStreamServer.getInstance();
        torrentStreamServer.setTorrentOptions(torrentOptions);
        torrentStreamServer.setServerHost(ipAddress);
        torrentStreamServer.setServerPort(8080);
        torrentStreamServer.startTorrentStream();
        torrentStreamServer.addListener(this);

        Log.d(TAG, "startStream: ");

        try {
            torrentStreamServer.startStream(streamUrl);
        } catch (IOException | TorrentStreamNotInitializedException e) {
            e.printStackTrace();
            eventSink.error(e.getMessage(), e.getMessage(), e);
        }
    }


    @Override
    public void onServerReady(String url) {
        Log.d(TAG, "onServerReady: " + url);
        eventSink.success(url);
    }

    @Override
    public void onStreamPrepared(Torrent torrent) {
        Log.d(TAG, "onStreamPrepared: ");
    }

    @Override
    public void onStreamStarted(Torrent torrent) {
        Log.d(TAG, "onStreamStarted: ");
    }

    @Override
    public void onStreamError(Torrent torrent, Exception e) {
        Log.d(TAG, "onStreamError: " + e);
        eventSink.error(e.getMessage(), e.getMessage(), e);
    }

    @Override
    public void onStreamReady(Torrent torrent) {
        Log.d(TAG, "onStreamReady: ");
    }

    @Override
    public void onStreamProgress(Torrent torrent, StreamStatus status) {
if (status.bufferProgress < 100){
    Log.d(TAG, "onStreamProgress: " + status.bufferProgress) ;
}
    }

    @Override
    public void onStreamStopped() {
        Log.d(TAG, "onStreamStopped: ");
    }

    public static InetAddress getIpAddress(Context context) throws UnknownHostException {
        WifiManager wifiMgr = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        WifiInfo wifiInfo = wifiMgr.getConnectionInfo();
        int ip = wifiInfo.getIpAddress();

        if (ip == 0) {
            return null;
        } else {
            byte[] ipAddress = convertIpAddress(ip);
            return InetAddress.getByAddress(ipAddress);
        }
    }

    private static byte[] convertIpAddress(int ip) {
        return new byte[]{
                (byte) (ip & 0xFF),
                (byte) ((ip >> 8) & 0xFF),
                (byte) ((ip >> 16) & 0xFF),
                (byte) ((ip >> 24) & 0xFF)};
    }
}
