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
del /s /q public\assets
del /s /q public\icons
del /s /q public\cors.json
del /s /q public\flutter_service_worker.js
del /s /q public\index.html
del /s /q public\main.dart.js
del /s /q public\manifest.json
del /s /q public\version.json

xcopy /s /y yollet-web-flutter\build\web\assets public\assets\
xcopy /s /y yollet-web-flutter\build\web\icons public\icons\
xcopy /s /y yollet-web-flutter\build\web\cors.json \public
xcopy /s /y yollet-web-flutter\build\web\flutter_service_worker.js public\
xcopy /s /y yollet-web-flutter\build\web\index.html public\
xcopy /s /y yollet-web-flutter\build\web\main.dart.js public\
xcopy /s /y yollet-web-flutter\build\web\manifest.json public\
xcopy /s /y yollet-web-flutter\build\web\version.json public\

cd yollet-web-flutter/
call flutter clean

goto end

:end