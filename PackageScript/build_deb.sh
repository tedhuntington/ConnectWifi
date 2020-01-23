echo "Build for ConnectWiFi"

echo "If you can't build deb package, you should be run following command to install related application"
echo "Command:sudo apt-get -y install dpkg-dev dh-make debhelper fakeroot"

cp debian debian_tmp -rf
cp debian/control.amd64 debian/control -f
cp debian/rules.amd64 debian/rules -f

dpkg-buildpackage -rfakeroot -b

echo "Install deb: dpkg -i packagename"
echo "apt-get --yes --fix-broken install"
echo "Un-install deb: dpkg -r packagename"

rm -rf debian
mv debian_tmp debian -f

echo "Copying .deb installer to desktop"
cp ../*.deb ~/Desktop -f

