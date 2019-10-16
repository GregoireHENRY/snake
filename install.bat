@echo off
echo SNAKE builder
echo.

echo Initializing SFML
for %%I in (wingfx\bin\sfml-graphics-2.dll wingfx\bin\sfml-system-2.dll wingfx\bin\sfml-window-2.dll wingfx\bin\sfml-audio-2.dll) do xcopy %%I "." /Y
echo.

echo Initializing folders
echo|set /p="0" > resource\HighestScore.txt
echo.

echo Compiling
wincompiler\bin\mingw32-make 
echo.

echo Installation finished succesfully!
