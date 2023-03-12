package com.example.watrix;

import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Handler;
import android.os.Looper;
import com.github.se_bastiaan.torrentstream.StreamStatus;
import com.github.se_bastiaan.torrentstream.Torrent;
import com.github.se_bastiaan.torrentstream.TorrentOptions;
import com.github.se_bastiaan.torrentstreamserver.TorrentServerListener;
import com.github.se_bastiaan.torrentstreamserver.TorrentStreamNotInitializedException;
import com.github.se_bastiaan.torrentstreamserver.TorrentStreamServer;
import io.flutter.plugin.common.MethodChannel;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class TorrentStreamHandler implements TorrentServerListener {

  private final String streamUrl;
  private final int fileIndex;
  private final MethodChannel methodChannel;
  private final File fileDir;
  private final Context context;

  private final Handler handler = new Handler(Looper.getMainLooper());

  private TorrentStreamServer torrentStreamServer;

  public TorrentStreamHandler(
    String streamUrl,
    int fileIndex,
    MethodChannel methodChannel,
    File fileDir,
    Context context
  ) {
    this.streamUrl = streamUrl;
    this.methodChannel = methodChannel;
    this.fileDir = fileDir;
    this.context = context;
    this.fileIndex = fileIndex;

    startStream();
  }

  public void stopStream() {
    torrentStreamServer.stopStream();
  }

  private void startStream() {
    TorrentOptions torrentOptions = new TorrentOptions.Builder()
      .saveLocation(fileDir).autoDownload(true)
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

    handler.post(() -> {
      try {
        torrentStreamServer.startStream(streamUrl);
      } catch (IOException | TorrentStreamNotInitializedException e) {
        e.printStackTrace();
        methodChannel.invokeMethod("onError", e);
      }
    });
  }

  @Override
  public void onServerReady(String url) {
    handler.post(() -> methodChannel.invokeMethod("onServerReady", url));
  }

  @Override
  public void onStreamPrepared(Torrent torrent) {
    if (fileIndex >= 0){
      torrent.setSelectedFileIndex(fileIndex);
    }
  }

  @Override
  public void onStreamStarted(Torrent torrent) {}

  @Override
  public void onStreamError(Torrent torrent, Exception e) {
    handler.post(() -> methodChannel.invokeMethod("onError", e.getMessage()));
  }

  @Override
  public void onStreamReady(Torrent torrent) {}

  @Override
  public void onStreamProgress(Torrent torrent, StreamStatus status) {
    handler.post(() -> methodChannel.invokeMethod("onProgress", status.bufferProgress));
  }

  @Override
  public void onStreamStopped() {}

  public static InetAddress getIpAddress(Context context)
    throws UnknownHostException {
    WifiManager wifiMgr = (WifiManager) context
      .getApplicationContext()
      .getSystemService(Context.WIFI_SERVICE);
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
    return new byte[] {
      (byte) (ip & 0xFF),
      (byte) ((ip >> 8) & 0xFF),
      (byte) ((ip >> 16) & 0xFF),
      (byte) ((ip >> 24) & 0xFF),
    };
  }
}
