#!/bin/bash

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
echo -e "Usage : $0 \"Name of working tree\" \"targets\" \"whiteList\"\n"
fi

# Script variables
WORKING_TREE=$1
TARGETS=`cat $2`
WHITELIST=`cat $3`

OUT=/home/laurent/android_themes_ressources
mkdir -p $OUT

cd $OUT
rm -rf *

# APPS process
for APPS in $TARGETS
do
cd $OUT
mkdir -p $APPS/res
cd $WORKING_TREE/$APPS/res
for SUB_DIR in `ls`
do
for PATTERN in $WHITELIST
do
if [ "$PATTERN" != "values" ]; then
if echo "$SUB_DIR" | grep -q "$PATTERN"; then
mkdir -p $OUT/$APPS/res/$SUB_DIR
cp -r $SUB_DIR $OUT/$APPS/res/ 2> /dev/null
fi
fi
done
done
mkdir -p $OUT/$APPS/res/values
cp -r values $OUT/$APPS/res/ 2> /dev/null
cd ../
cp -r AndroidManifest.xml $OUT/$APPS/AndroidManifest.xml 2> /dev/null
done
