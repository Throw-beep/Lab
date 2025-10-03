#!/bin/bash

# Add i386 architecture if not already added
sudo dpkg --add-architecture i386 || true
sudo apt-get update

# Install dependencies
sudo apt-get install -y build-essential autoconf automake libxmu-dev gcc git

# Ensure NS2 folder exists
if [ ! -d "ns-allinone-2.35" ]; then
    echo "ns-allinone-2.35 folder not found. Cloning..."
    git clone https://github.com/idmidr/ns-allinone-2.35.git
fi

# Install NAM from local .deb
if [ -f "nam_1.14_amd64.deb" ]; then
    sudo dpkg -i nam_1.14_amd64.deb || sudo apt-get install -f -y
else
    echo "NAM .deb file not found in the current directory."
fi

# Install NS2
cd ns-allinone-2.35/ || exit
./install

# Set environment variables
echo -e "\n# NS2 environment variables" >> ~/.bashrc
echo 'export PATH=$PATH:~/ns-allinone-2.35/bin:~/ns-allinone-2.35/tcl8.5.10/unix:~/ns-allinone-2.35/tk8.5.10/unix' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/ns-allinone-2.35/otcl-1.14:~/ns-allinone-2.35/lib' >> ~/.bashrc
echo 'export TCL_LIBRARY=$TCL_LIB:~/ns-allinone-2.35/tcl8.5.10/library:/usr/lib' >> ~/.bashrc

# Apply environment
source ~/.bashrc

echo "NS2 installation complete. You can now run 'ns'."

