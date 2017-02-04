#! /bin/sh
# Syntaxe information
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
echo -e "Usage : $0 \"Name of repository\" \"List of project\" \"Name of the git remote\"\n"
fi

# Constant
MY_GIT=rlcDev
ANDROID_BRANCH=android-7.1 # FIXED FOR OMNIROM

# Script vars
PATH_BUILD=$1
PROJECT_LIST=`cat $2`
GIT_REMOTE=$3
MESSAGE="Automatically\ merge"

echo -e "--------------Start merging $3--------------\n"

# Beginning merge
for PROJECT in $PROJECT_LIST
do
cd $PATH_BUILD
# Check if project exist
if [ -e $PROJECT ]; then
cd $PATH_BUILD$PROJECT

echo -e "\n-Merge $PROJECT"

git fetch $GIT_REMOTE
git checkout $MY_GIT/$ANDROID_BRANCH
git merge -m "$MESSAGE" $GIT_REMOTE/$ANDROID_BRANCH

git push $MY_GIT HEAD:$ANDROID_BRANCH

sleep 1
else 
echo -e "$PROJECT does not exist, finished.."
exit 0
fi

done

echo -e "\n--------------Merge is finished--------------\n"
