#!/bin/bash
# Used to not let a volume named MYBOOK sleep

volpresent=$(mount | grep Chromium | wc -c)

if [ $volpresent -gt 0 ]
then
    touch /Volumes/Chromium/.hiddenfile
fi