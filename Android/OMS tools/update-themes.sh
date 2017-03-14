#!/bin/bash

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
echo -e "Usage : $0 \"Name of working tree\" \"apps_target\" \"frameworks_target\"\n"
fi

# Script variables
WORKING_TREE=$1
APPS_TARGET=`cat $2`
FRAMEWORKS_TARGET=`cat $3`

OUT=/home/laurent/android_themes_ressources
mkdir $OUT

cd $OUT
rm -rf *

# APPS process
for APPS in $APPS_TARGET
do
mkdir -p $APPS
cp -r $WORKING_TREE/$APPS/res $OUT/$APPS/
cp -r $WORKING_TREE/$APPS/AndroidManifest.xml $OUT/$APPS/AndroidManifest.xml

done

# APPS process
for FRAMEWORKS in $FRAMEWORKS_TARGET
do
mkdir -p $FRAMEWORKS
cp -r $WORKING_TREE/$FRAMEWORKS/res $OUT/$FRAMEWORKS/
cp -r $WORKING_TREE/$FRAMEWORKS/AndroidManifest.xml $OUT/$FRAMEWORKS/AndroidManifest.xml
done

