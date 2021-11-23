@echo off
rem
rem Usage:
rem   release.bat <config>
rem   release.bat
rem

:build
cd yollet-web-flutter/

call flutter clean
rem When flutter sdk directory is changed, pubspec.lock should be deleted.
del pubspec.lock
call flutter build web

cd ..

xcopy /s /y yollet-web-flutter\build\web\assets \public\assets
xcopy /s /y yollet-web-flutter\build\web\icons \public\icons
xcopy /s /y yollet-web-flutter\build\web\cors.json \public
xcopy /s /y yollet-web-flutter\build\web\flutter_service_worker.js \public
xcopy /s /y yollet-web-flutter\build\web\index.html \public
xcopy /s /y yollet-web-flutter\build\web\main.dart.js \public
xcopy /s /y yollet-web-flutter\build\web\manifest.json \public
xcopy /s /y yollet-web-flutter\build\web\version.json \public

call flutter clean

goto end

:end