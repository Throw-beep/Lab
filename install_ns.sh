#!/bin/bash

sudo dpkg --add-architecture i386 || true
sudo apt-get update

sudo apt-get install -y build-essential autoconf automake libxmu-dev gcc git

git clone https://github.com/idmidr/ns-allinone-2.35.git

sudo dpkg -i nam_1.14_amd64.deb || sudo apt-get install -f -y


cd ns-allinone-2.35/ || exit
./install


echo -e "\n# NS2 environment variables" >> ~/.bashrc
echo 'export PATH=$PATH:~/ns-allinone-2.35/bin:~/ns-allinone-2.35/tcl8.5.10/unix:~/ns-allinone-2.35/tk8.5.10/unix' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/ns-allinone-2.35/otcl-1.14:~/ns-allinone-2.35/lib' >> ~/.bashrc
echo 'export TCL_LIBRARY=$TCL_LIB:~/ns-allinone-2.35/tcl8.5.10/library:/usr/lib' >> ~/.bashrc


source ~/.bashrc


