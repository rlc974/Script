#! /bin/sh
echo -e "---------------Android ->Omnirom<- Building----------------"
sleep 3
#Warming format
if [ -z $1 ] || [ -z $2 ]; then 
echo -e "Usage : $0 \"path repository\" \"device name\"\n"
exit 0
fi

#For script 
PATH_BUILD=$1
let "THREAD_NB=26" #Fixed for me
DEVICE=$2

#Genrate fake env
echo -e "--Generate fake env--"
sleep 3
cd $PATH_BUILD
cd venv/ && source bin/activate

#Prepare env
cd $PATH_BUILD
echo -e "--Prepare android env--"
sleep 3
source build/envsetup.sh

#CLEAN UP
##Clean manifests previews device repo
cd $PATH_BUILD
echo -e "--Some clean up...--"

#RoomService
#cd .repo/local_manifests/
#if [ -e roomservice.xml ]; then
#rm -rf roomservice.xml
#echo -e "roomservice.xml delected !"
#cd $PATH_BUILD
#fi

#Previous build
while [ "$CLEAN" != "y" ] && [ "$CLEAN" != "Y" ] && [ "$CLEAN" != "N" ] && [ "$CLEAN" != "n" ]
do
read -p "Do you want to clean up previous builds (y|n) ?" CLEAN
done

case $CLEAN in 
		y | Y)
echo -e "Cleaning waste of last build"
sleep 3
make clean
make clobber
ccache -C
esac

#Sync source
while [ "$SYNC" != "y" ] && [ "$SYNC" != "Y" ] && [ "$SYNC" != "N" ] && [ "$SYNC" != "n" ]
do
read -p "Do you want to sync repositories (y|n) ?" SYNC
done

case $SYNC in 
		y | Y)
echo -e "Synchronizing sources"
sleep 3
repo sync -j$THREAD_NB
esac

#Building
echo -e "-----------------------------------------------------------------"
echo -e "---------------Start Building Omnirom for $DEVICE----------------"
echo -e "-----------------------------------------------------------------"

#read -p "Enter your device " DEVICE
brunch $DEVICE
sleep 3 

#Move build to specific folder
echo -e "Move build to a specific folder..."
cd ../
FOLDER_NAME="$DEVICE flashable"
mkdir "$FOLDER_NAME"
cd "$FOLDER_NAME"
cp $PATH_BUILD/out/target/product/$DEVICE/omni-*.zip "$PWD"

echo -e "Your build is ready, grab it in $FOLDER_NAME, flash it ! "