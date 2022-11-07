#! /bin/bash
#Yahia Walid Mohamed Ahmed Zaky-----Group 3-------Lab 1------ID 7137


dir=$1			#Source folder path
backupdir=$2		#Destination folder path (backup folder)
interval_secs=$3	#Time to wait in order to check for any recent changes
max_backups=$4

if [ ! $# -eq 4 ]
then
	echo "Please enter full path of the directory to be backed up" 
	read dir 
	
	echo "Please enter full path of the backup directory"
	read backupdir 
	
	echo "Please enter the time to wait between each check" 
	read interval_secs 
	
	echo "Please enter the maximum number of backup directories" 
	read max_backups 
fi




#making sure that source directory exists
while [[ ! -d $dir ]]
do
	echo ""
	echo "directory to be backed up does not exist"
	echo "please enter the full path of an existing directory"
	read dir	
done	



#creating backup directory if it does not exist
if ! [[ -d $backupdir ]]
then
	echo "Backup directory does not exist"
	mkdir -p $backupdir
	echo "Backup directory is now created"
fi



#using regex to make sure that all characters in the interval_secs and max_backups are digits
regex='^[0-9]+$'


#making sure that interval_secs is a number greater than 0
while [[ ! $interval_secs =~ $regex ]] || [[ $interval_secs -le 0 ]]
do
	echo "Please enter a valid number greater than 0 of seconds to wait between each check"
	read interval_secs

done



#making sure that max_backups is a number greater than 0
while [[ ! $max_backups =~ $regex ]] || [[ $max_backups -le 0 ]]
do
	echo "Please enter a valid number of seconds greater than 0 to be the maximum number of backups"
	read max_backups

done



echo ""
echo "Inputs:"
echo "dir 		= $dir "
echo "backupdir 	= $backupdir "
echo "interval_secs 	= $interval_secs seconds"
echo "max_backups 	= $max_backups "
echo ""

cd $dir

files=$( ls )
echo "Files to be backed up : "
echo "$files"
echo ""



	

ls -lR  > "$backupdir/directory-info.last"	#saving dir current status to directory-info.last


currentdate=$( date '+%Y-%m-%d-%H-%M-%S' )	#storing current date in variable currentdate
mkdir "$backupdir/$currentdate"
cp -r $files "$backupdir/$currentdate"		#first backup
echo "Files backed up from $dir to $backupdir"
count=1						#counts number of backups


flag=0						#to check when reaching max dirs (used to prevent repeating of reached max dirs msg)

#infinite loop that checks and updates the backup
while [ true ]
do

	sleep $interval_secs			#sleep for interval_secs seconds
	echo ""
	echo "slept for $interval_secs seconds"
	ls -lR  > "$backupdir/directory-info.new"		#new dir info
	
	
	
	#checking if both info files are the same
	cmp "$backupdir/directory-info.last" "$backupdir/directory-info.new"
	result=$?
	
	if [ $result -eq 0 ]			#same info (no change in src dir)
	then
		#main directory has not changed (do nth)
		echo "no recent changes has occured"
	else
		
		
		#backup but check number of backups first and update info files	
		if [ $count -eq $max_backups ]
		then	
			
			if [ $flag -eq 0 ]
			then
				echo "Reached a maximum of $max_backups backup directories"
			fi
			
			echo "removing oldest backup" 
			
			#deleting first folder in dir which is the oldest one
			
			cd "$backupdir"
			folders=($(ls))
			rm -r ${folders[0]}
			
			
			echo "successfully removed oldest backup"
			count=$((count-1))
			
			flag=1
	
		fi
		
		
		#backing up
		currentdate=$( date '+%Y-%m-%d-%H-%M-%S' )
		mkdir "$backupdir/$currentdate"
		
		cd "$dir"
		files=$( ls )
		cp -r $files "$backupdir/$currentdate"
		echo "Files backed up from $dir to $backupdir"
		
		#updating info file
		ls -lR  > "$backupdir/directory-info.last"
		count=$((count+1))
		
		
		
	fi


done	
	
	
	
	
	
	
