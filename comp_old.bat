call clear

set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_192
set ANDROID_HOME=C:\Users\Maick7\AppData\Local\Android\android-sdk
set DEV_HOME=%CD%

set AAPT_PATH=%ANDROID_HOME%/build-tools/28.0.3/aapt.exe
set DX_PATH=%ANDROID_HOME%/build-tools/28.0.3/dx.bat
set ANDROID_JAR=%ANDROID_HOME%/platforms/android-24/android.jar
set ADB=%ANDROID_HOME%/platform-tools/adb.exe

set PACKAGE_PATH=com/example/testapp
set PACKAGE=com.example.testapp
set MAIN_CLASS=MainActivity

REM create R.java
call %AAPT_PATH% package -f -m -S %DEV_HOME%/res -J %DEV_HOME%/src -M %DEV_HOME%/AndroidManifest.xml -I %ANDROID_JAR%
pause

REM compile, convert class->dex and create APK
call "%JAVA_HOME%/bin/javac" -d %DEV_HOME%/obj -cp %ANDROID_JAR% -sourcepath %DEV_HOME%/src %DEV_HOME%/src/%PACKAGE_PATH%/*.java
pause

call %DX_PATH% --dex --output=%DEV_HOME%/bin/classes.dex %DEV_HOME%/obj
pause

call %AAPT_PATH% package -f -M %DEV_HOME%/AndroidManifest.xml -S %DEV_HOME%/res -I %ANDROID_JAR% -F %DEV_HOME%/bin/AndroidTest.unsigned.apk %DEV_HOME%/bin
pause

REM create key and signed APK
call "%JAVA_HOME%/bin/keytool" -genkey -validity 10000 -dname "CN=AndroidDebug, O=Android, C=US" -keystore %DEV_HOME%/AndroidTest.keystore -storepass android -keypass android -alias androiddebugkey -keyalg RSA -keysize 2048
call "%JAVA_HOME%/bin/jarsigner" -sigalg SHA1withRSA -digestalg SHA1 -keystore %DEV_HOME%/AndroidTest.keystore -storepass android -keypass android -signedjar %DEV_HOME%/bin/AndroidTest.signed.apk %DEV_HOME%/bin/AndroidTest.unsigned.apk androiddebugkey
pause

REM reinstall and start APK on device
call %ADB% uninstall %PACKAGE%
call %ADB% install %DEV_HOME%/bin/AndroidTest.signed.apk
call %ADB% shell am start -n %PACKAGE%/%PACKAGE%.%MAIN_CLASS%
pause

# 03
