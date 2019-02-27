# testapp
HelloWorld for Android on Notepad. Java 8 и Android N

12 сентября 2016 в 18:05
Пишем, собираем и запускаем HelloWorld для Android в блокноте. Java 8 и Android N 

https://habr.com/ru/post/309504/

set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_73
set ANDROID_HOME=C:\Users\<user>\AppData\Local\Android\android-sdk
set DEV_HOME=%CD%

set JACK_JAR="%ANDROID_HOME%\build-tools\24.0.2\jack.jar"
set AAPT_PATH="%ANDROID_HOME%\build-tools\24.0.2\aapt.exe"
set ANDROID_JAR="%ANDROID_HOME%\platforms\android-24\android.jar"
set ADB="%ANDROID_HOME%\platform-tools\adb.exe"
set JAVAVM="%JAVA_HOME%\bin\java.exe"

set PACKAGE_PATH=com/example/testapp
set PACKAGE=com.example.testapp
set MAIN_CLASS=MainActivity

call %AAPT_PATH% package -f -m -S %DEV_HOME%\res -J %DEV_HOME%\src -M %DEV_HOME%\AndroidManifest.xml -I %ANDROID_JAR%

%JAVAVM% -jar %JACK_JAR% --output-dex "%DEV_HOME%\bin" -cp %ANDROID_JAR% -D jack.java.source.version=1.8 "%DEV_HOME%\src\com\example\testapp\R.java" "%DEV_HOME%\src\com\example\testapp\MainActivity.java" 

call %AAPT_PATH% package -f -M %DEV_HOME%/AndroidManifest.xml -S %DEV_HOME%/res -I %ANDROID_JAR% -F %DEV_HOME%/bin/AndroidTest.unsigned.apk %DEV_HOME%/bin

call %JAVA_HOME%/bin/keytool -genkey -validity 10000 -dname "CN=AndroidDebug, O=Android, C=US" -keystore %DEV_HOME%/AndroidTest.keystore -storepass android -keypass android -alias androiddebugkey -keyalg RSA -v -keysize 2048
call %JAVA_HOME%/bin/jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore %DEV_HOME%/AndroidTest.keystore -storepass android -keypass android -signedjar %DEV_HOME%/bin/AndroidTest.signed.apk %DEV_HOME%/bin/AndroidTest.unsigned.apk androiddebugkey

call %ADB% uninstall %PACKAGE%
call %ADB% install %DEV_HOME%/bin/AndroidTest.signed.apk
call %ADB% shell am start %PACKAGE%/%PACKAGE%.%MAIN_CLASS%



====================================
HelloWorld от Android Studio (2.1.3)
====================================
│   .gitignore
│   build.gradle
│   gradle.properties
│   gradlew
│   gradlew.bat
│   local.properties
│   MyApplication2.iml
│   settings.gradle
│
├───.gradle
│   └───2.14.1
│       └───taskArtifacts
│               cache.properties
│               cache.properties.lock
│               fileHashes.bin
│               fileSnapshots.bin
│               fileSnapshotsToTreeSnapshotsIndex.bin
│               taskArtifacts.bin
│
├───.idea
│   │   .name
│   │   compiler.xml
│   │   encodings.xml
│   │   gradle.xml
│   │   misc.xml
│   │   modules.xml
│   │   runConfigurations.xml
│   │   workspace.xml
│   │
│   ├───copyright
│   │       profiles_settings.xml
│   │
│   └───libraries
│           animated_vector_drawable_24_2_0.xml
│           appcompat_v7_24_2_0.xml
│           hamcrest_core_1_3.xml
│           junit_4_12.xml
│           support_annotations_24_2_0.xml
│           support_compat_24_2_0.xml
│           support_core_ui_24_2_0.xml
│           support_core_utils_24_2_0.xml
│           support_fragment_24_2_0.xml
│           support_media_compat_24_2_0.xml
│           support_v4_24_2_0.xml
│           support_vector_drawable_24_2_0.xml
│
├───app
│   │   .gitignore
│   │   app.iml
│   │   build.gradle
│   │   proguard-rules.pro
│   │
│   ├───libs
│   └───src
│       ├───androidTest
│       │   └───java
│       │       └───com
│       │           └───example
│       │               └───kciray
│       │                   └───myapplication
│       │                           ApplicationTest.java
│       │
│       ├───main
│       │   │   AndroidManifest.xml
│       │   │
│       │   ├───java
│       │   │   └───com
│       │   │       └───example
│       │   │           └───kciray
│       │   │               └───myapplication
│       │   │                       MainActivity.java
│       │   │
│       │   └───res
│       │       ├───drawable
│       │       ├───layout
│       │       │       activity_main.xml
│       │       │
│       │       ├───mipmap-hdpi
│       │       │       ic_launcher.png
│       │       │
│       │       ├───mipmap-mdpi
│       │       │       ic_launcher.png
│       │       │
│       │       ├───mipmap-xhdpi
│       │       │       ic_launcher.png
│       │       │
│       │       ├───mipmap-xxhdpi
│       │       │       ic_launcher.png
│       │       │
│       │       ├───mipmap-xxxhdpi
│       │       │       ic_launcher.png
│       │       │
│       │       ├───values
│       │       │       colors.xml
│       │       │       dimens.xml
│       │       │       strings.xml
│       │       │       styles.xml
│       │       │
│       │       └───values-w820dp
│       │               dimens.xml
│       │
│       └───test
│           └───java
│               └───com
│                   └───example
│                       └───kciray
│                           └───myapplication
│                                   ExampleUnitTest.java
│
├───build
│   └───generated
│           mockable-android-24.jar
│
└───gradle
    └───wrapper
            gradle-wrapper.jar
            gradle-wrapper.properties



