-keep class com.frostwire.jlibtorrent.swig.libtorrent_jni {*;}
-keep class com.frostwire.jlibtorrent.swig.** { *; }

-keepclasseswithmembernames,includedescriptorclasses class com.frostwire.jlibtorrent.swig.libtorrent_jni {
  native <methods>;
}