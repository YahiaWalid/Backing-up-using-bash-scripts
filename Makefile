#Hardcoded input   #change for your source and destination directories
src=/home/yahia/Desktop/source
dst=/home/yahia/Desktop/backup01
time_secs=10
max_backups=2


all: backup
	
	
	

backup:
	@#creating backupdir incase it does not exist
	@if [ ! -d ${dst} ];  then \
		mkdir -p ${dst}; \
	fi 
		
	./backup.sh ${src} ${dst} ${time_secs} ${max_backups}


#deletes backup folder	
clean:	
	rm -r ${dst}
	
