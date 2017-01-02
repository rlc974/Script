#! /bin/sh
echo -e "---------------Android ->AOSP<- Building----------------"
sleep 3
#Warming format
if [ -z $1 ]; then 
echo -e "Usage : $0 path repository\n"
exit 0
fi

#For script 
PATH_BUILD=$1
let "THREAD_NB=26" #Fixed for me

#Genrate fake env
echo -e "Generate fake env"
sleep 3
cd $PATH_BUILD
cd venv/ && source bin/activate

#CLEAN UP
##Clean manifests previews device repo
cd $PATH_BUILD
echo -e "Some clean up..."

#RoomService
cd .repo/local_manifests/
if [ -e roomservice.xml ]; then
rm -rf roomservice.xml
echo -e "roomservice.xml delected !"
cd $PATH_BUILD
fi

#Previous build
cd $PATH_BUILD
echo -e "Prepare android env"
sleep 3
source build/envsetup.sh
echo -e "Clean waste of last build"
sleep 3
make clean
make clobber
ccache -C

#Sync source
echo -e "Sync repo with source"
repo sync -j$THREAD_NB
sleep 3

#Building
echo -e "---------------------------------------------"
echo -e "---------------Start Building----------------"
echo -e "---------------------------------------------"

read -p "Enter your device " DEVICE
brunch $DEVICE
sleep 3 

echo -e "Your build is ready, grab it, flash it ! "