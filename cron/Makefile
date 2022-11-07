#hardcoded input to be changed by user 
backupdir="/home/yahia/Desktop/source"
dir="/home/yahia/Desktop/backup01"
max_backups=10

all: createfile cron
		

cron :
	@./backup-cron.sh ${dir} ${backupdir} ${max_backups} 
