
#for exp 8 and 9 
sudo dpkg --add-architecture i386 
sudo dpkg -i nam_1.14_amd64.deb 

#exp 7 starts from here
sudo apt-get update

sudo apt-get install -y build-essential autoconf automake libxmu-dev gcc git

git clone https://github.com/idmidr/ns-allinone-2.35.git

cd ns-allinone-2.35/ 
./install

sudo apt install gedit
gedit ~/.bashrc

export PATH=$PATH:~/ns-allinone-2.35/bin:~/ns-allinone-2.35/tcl8.5.10/unix:~/ns-allinone-2.35/tk8.5.10/unix
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/ns-allinone-2.35/otcl-1.14:~/ns-allinone-2.35/lib
export TCL_LIBRARY=$TCL_LIB:~/ns-allinone-2.35/tcl8.5.10/library:/usr/lib

source ~/.bashrc

sudo apt install ns2
ns



