#!/bin/bash

echo -e "Editing Makefile..."

cd /home/pi/rpi-fb-matrix
sed -i -e 's/export HARDWARE_DESC=adafruit-hat/export HARDWARE_DESC=regular/g' ./Makefile
echo -e "Done."

echo -e "Compiling rpi-fb-matrix..."
make clean all
echo -e "Done."

echo -e "Editing matrix config..."
sed -i -e 's/  ( { order = 1; rotate =   0; }, { order = 0; rotate =   0; } ),/  ( { order = 1; rotate = 0; }i, { order = 0; rotate = 0; } )/g' ./matrix.cfg
sed -i '/  ( { order = 2; rotate = 180; }, { order = 3; rotate = 180; } )/d' ./matrix.cfg
sed -i -e 's/display_width = 64;/display_width = 32;/g' ./matrix.cfg
sed -i -e 's/display_height = 32;/display_width = 8;/g' ./matrix.cfg
sed -i -e 's/panel_width = 32;/panel_width = 16;/g' ./matrix.cfg
sed -i -e 's/panel_height = 32;/panel_height = 8;/g' ./matrix.cfg
sed -i -e 's/chain_length = 4;/chain_length = 2;/g' ./matrix.cfg
printf "crop_origin = (0, 0)" >> ./matrix.cfg
echo -e "Done."

echo -e "Editing Raspberry config..."
cd /home/pi
sudo sed -i -e 's/dtparam=audio=on/dtparam=audio=off/g' /boot/config.txt
sudo printf "crop_origin = (0, 0)" >> /boot/config.txt
echo -e "Done."

echo -e "Copying service file to systemd..."
cd /home/pi/like-counter-pi
sudo cp /home/pi/like-counter-pi/matrix.service /etc/systemd/system/matrix.service
echo -e "Done."

echo -e "Enabling matrix service..."
systemctl enable matrix.service
systemctl start matrix.service
echo -e "Done."

echo -e "Successfully finished"
