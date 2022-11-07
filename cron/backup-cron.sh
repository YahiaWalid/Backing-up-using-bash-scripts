#! /bin/bash
#Yahia Walid Mohamed Ahmed Zaky-----Group 3-------Lab 1------ID 7137


#hardcoded directories
if [[ ! $# -eq 3  ]]
then
	dir="/home/yahia/Desktop/source"
	backupdir="/home/yahia/Desktop/backup01"
	max_backups=10
fi	
	
#creating backup directory if it does not exist
if ! [[ -d $backupdir ]]
then
	echo "Backup directory does not exist"
	mkdir -p $backupdir
	echo "Backup directory is now created"
fi

cd $dir

files=$( ls )



	ls -lR  > "$backupdir/directory-info.new"		
	
	
	if [[ -f "$backupdir/directory-info.last" ]]
	then		
		cmp "$backupdir/directory-info.last" "$backupdir/directory-info.new"
		result=$?
	else
		result=1
	fi
	
	
	if [ $result -eq 0 ]			#same info (no change in src dir)
	then
		#main directory has not changed (do nth)
		echo "no recent changes has occured"
	else
		
		#backing up
		currentdate=$( date '+%Y-%m-%d-%H-%M-%S' )
		mkdir "$backupdir/$currentdate"
		
		cd "$dir"
		files=$( ls )
		cp -r $files "$backupdir/$currentdate"
		echo "Files backed up from $dir to $backupdir"
		
		#updating info file
		ls -lR  > "$backupdir/directory-info.last"
		
		cd $backupdir
		count=` ls -l | grep ^d | wc -l` 
		echo "count is equal to $count"
		cd $dir
		
		
		
		#backup but check number of backups first and update info files	
		if [[ $count -eq $((max_backups+1)) ]]
		then	
				
			echo "removing oldest backup" 
			
			#deleting first folder in dir which is the oldest one
			cd "$backupdir"
			folders=($(ls))
			rm -r ${folders[0]}
			echo "successfully removed oldest backup"
			
		fi
		
	
			
		
				
	fi


	
	
	
	
	
	
