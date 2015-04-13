#!/bin/sh
LOGFILE=~/.uscode.log
touch $LOGFILE
date >> $LOGFILE
cd ~/src/github.com/divegeek/uscode
git pull -q origin master
rm -rf code
python /Users/studor/src/github.com/divegeek/uscode/src/retrieve_code.py . >> $LOGFILE
git add code >> $LOGFILE
DIFFLOG=`git status --porcelain`
if [ ! -z "$DIFFLOG" ]; then
    #echo "$DIFFLOG" >> $LOGFILE
    #git commit -m "`date`"
    #git tag -f -a -m "Daily tag" `date +"%F"`
    #git push --tags origin master
fi

