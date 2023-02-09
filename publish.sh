#!/bin/bash

VERSION=""
FILE=""

#get parameters
while getopts 'f:v:' flag
do
  case "${flag}" in
    v) 
      VERSION=${OPTARG}
    ;;
    f) 
      FILE=${OPTARG}
      if [[ $FILE == '' ]]
      then 
        echo "script usage: Please proide file name" >&2
        exit 1
      fi
    ;;
     ?)
      echo "script usage: $(basename \$0) [-v] [-f]" >&2
      exit 1
      ;;
  esac
done

#get highest tag number, and add 1.0.0 if doesn't exist
CURRENT_VERSION=`cat "./$FILE/version"`
echo $CURRENT_VERSION
if [[ $CURRENT_VERSION == '' ]]
then
  CURRENT_VERSION='1.0.0'
fi
echo "Current Version: $CURRENT_VERSION"


#replace . with space so can split into an array
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })

#get number parts
VNUM1=${CURRENT_VERSION_PARTS[0]}
VNUM2=${CURRENT_VERSION_PARTS[1]}
VNUM3=${CURRENT_VERSION_PARTS[2]}

if [[ $VERSION == 'major' ]]
then
  VNUM1=$((VNUM1+1))
  VNUM2=0
  VNUM3=0
elif [[ $VERSION == 'minor' ]]
then
  VNUM2=$((VNUM2+1))
  VNUM3=0
elif [[ $VERSION == 'patch' ]]
then
  VNUM3=$((VNUM3+1))
else
  echo "No version type (https://semver.org/) or incorrect type specified, try: -v [major, minor, patch]"
  exit 1
fi

#create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
echo "($VERSION) updating $CURRENT_VERSION to $NEW_TAG"

echo "$NEW_TAG" > "./$FILE/version"

git add "./$FILE/version"
git commit -m "$FILE new version"
echo "Tagged with $FILE--$NEW_TAG"
git tag "$FILE--$NEW_TAG"
git push --tags
git push

exit 0