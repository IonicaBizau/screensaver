gcc -o getIdle getIdle.c -lXss -lX11

echo "> Copying getIdle executable in deb directory ..."
cp ./getIdle        ./deb/64bit/usr/bin/getIdle
cp ./screensaver.sh ./deb/64bit/usr/bin/screensaver

echo "> Removing all deb files from ./deb/64bit directory ..."
rm -rf ./deb/64bit/*.deb

echo "> Building deb file ..."
dpkg -b deb/64bit/ deb/64bit/64-dev-release.deb

echo " * Finished."
