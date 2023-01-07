-keep class com.frostwire.jlibtorrent.swig.libtorrent_jni {*;}
-keep class com.frostwire.jlibtorrent.swig.** { *; }

-keepclasseswithmembernames,includedescriptorclasses class com.frostwire.jlibtorrent.swig.libtorrent_jni {
  native <methods>;
}

-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class org.videolan.libvlc.** { *; } 