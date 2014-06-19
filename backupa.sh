#!/bin/bash
# backupscript

BASEURL="/mnt/alias/backup"
MAILURL="/mnt/alias/storage/shishaMail"
CLOUDURL="/mnt/alias/storage/owncloud"

DAY=`eval date +"%d"`
MONTH=`eval date +"%m"`
YEAR=`eval date +"%Y"`
HOUR=`eval date +"%H"`
MINUTE=`eval date +"%M"`

PIMPURL=$BASEURL/$YEAR/$MONTH/$DAY/

COMMAND="cd $PIMPURL"
$COMMAND 2>/dev/null

if [ $? -eq 0 ]
then
		echo "Command 1 was successful"
else
		echo "There ain't folders!!"
		echo "I'll mkdir some!"

		COMMAND="mkdir -p $PIMPURL"
		$COMMAND 2>/dev/null
fi
if [ $? -eq 0 ]
then
		echo 'Command 2 was successful'
		echo "STARTING MAIL BACKUP"

		COMMAND="tar cfvz ${PIMPURL}shisha_${HOUR}_${MINUTE}_.data.tar.gz ${MAILURL}"
		$COMMAND 2>/dev/null

		if [ $? -eq 0 ]
		then
				echo 'MAIL BACKUP SUCCESSFUL'L
		else
				echo "FAILURE!!"
		fi

		HOUR=`eval date +"%H"`
		MINUTE=`eval date +"%M"`

		echo "STARTING CLOUD BACKUP"

		COMMAND="tar cfvz ${PIMPURL}cloud_${HOUR}_${MINUTE}_.data.tar.gz ${CLOUDURL}"
		$COMMAND 2>/dev/null

		if [ $? -eq 0 ]
		then
				echo 'CLOUD BACKUP SUCCESSFUL'L
		else
				echo "FAILURE!!"
		fi

else
		echo 'Nope! Must be some kind of strage Err0r!!'
fi
