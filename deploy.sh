#!/bin/bash -e
BASE=$(pwd)
PUBLIC=public
THEME=$BASE/themes/hyde
rm -rf $PUBLIC
hugo 

pushd $THEME/compass
compass compile
popd


if [ ! -d _deploy ]
then
    git clone https://github.com/bl4ck5un/bl4ck5un.github.io _deploy
fi

cd _deploy

rm -rf *
cp -rf ../$PUBLIC/* .
if [ -f $BASE/CNAME ]
then
    cp -f $BASE/CNAME .
fi

find . -name "*.DS_Store" -type f -delete

git add --all
git commit -m "Site updated `date`"
git push

echo "Done"

