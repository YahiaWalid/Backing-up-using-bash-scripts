# Backup Project



## Code overview





### backup bash file



The script first takes four inputs from the user which are 

	• dir:            the source directory that have list of file we need to backup.

	• backupdir:      the destination directory that will have the backup

	• interval-secs:  time to wait between every check

	• max-backups:   maximum number of backups needed to be reserved



./backup.sh dir backupdir interval-secs max-backups



Once the script is executed, it checks whether the user entered four inputs or not.If not, it asks the user for the inputs. Then it validates each input. It checks if the directory to be backed up exists. If not it tells the user to re enter it again and keeps checking again in a while loop until the user enters an existing directory. Then it creates the backup directory that the user entered in case it does not exist. Using a regular expression, the interval_secs and max_backups variables are checked to make sure that they are numbers not strings and also they are checked to see if they are greater than zero.



The user inputs are printed to the user and then the script changes directory to the directory to be backed up and stores all the files/directories in that directory in a variable called files. The the current status of the backup directory is stored in the file directory-info.last(located in the backup directory next to the directories named by the dates ). The current date in the format YYYY-MM-DD-hh-mm-ss is saved in a variable  currentdate.



The current directory which is to be backed up is copied to the desired backup folder with the current date as its directory name. A counter is created and initialized to 1 identifying that there is only one backup directory now which was just created. A flag is assigned to 0 which will be used later to prevent printing a message to the user every backup.



Next is an infinite while loop. In that loop we sleep for an interval of seconds equal to interval_secs. Then the current status (which is now new) of the source folder(whose path is stored in the variable dir) is stored in the file directory-info.new . Using the cmp command, both directory-info.new (current status) and directory-info.last (old status) are compared and their result is stored in the variable result . The result variable is checked , if its value is 0 (both files are the same indicating no changes have occured) then it will print to the user that no changes has occured since the last backup.



If the variable result was not 0 then there was changes in the source directory so we enter the else block of the previous if statement . Now we check wether the count variable has reached the maximum number of backups which is stored in max_backups. In case we reached maximum backups ,the script deletes the oldest backup. To delete the oldest backup the script changes directory to the backup directory (backupdir) which contains directories named by the date they were backed up in. In this directory to get the directory with the oldest date to remove it , we store all the names of the directories in a array called folders using the following command "folders=($(ls))". ls by default sorts the directories in an ascending order by default so the first element in the "folders" array is the directory with the most ascending name and since all the folders hold the same date format so the first element holds the name of the oldest directory. Now the oldest directory is removed by the command "rm -r ${folders[0]}" which recursively deletes the directory and any directory within.



Then count variable is decremented by 1 as a directory was just removed and the flag was set to 1 indicating that the maximum numbers of directories was reached to prevent printing the same "Reached a maximum of backup directories" each time from now on.



Now that the oldest directory was deleted (in case maximum backups number was reached) , the source directory is backed up with the current date as its directory name in the backup directory . The new status that was just backed up is now stored in the file directory-info.last and the count variable is incremented by 1.



And then the infinite loop keeps looping repeating the same steps all over again







### MakeFile



The arguments to be passed on to the bash script are hard coded at the beginning of the file and can be changed by the user.



There are three targets in the Makefile (all-backup-clean)



The all target (which by default is the default goal and  executes when using the "make" command in the directory where the makefile exists) executes the backup target.



The backup target checks whether the backup directory exists or not and creates it along with its path in case it does not exists. Then the target executes the bash script and passess the arguments which were defined earlier as the following 

```
./backup.sh ${src} ${dst} ${time_secs} ${max_backups}
```



There is a third target which is called "clean" which deletes the backup directory along with all backed up directories inside which can be executed using

```
make clean
```







## Prerequisites



No necessary prerequisites are required to run the bash file. User should make sure that the bash file is executable by running the following command in the directory where the bash file is located

```
chmod +x backup.sh
```



 It is preferred that the user is up to date. To update the system the following command can be used

```
sudo apt-get update
```



As for the Makefile to run it, the user should install the make package using

```
sudo apt install make
```



## User Manual



The user has two options to run the backup.



Option 1 : using the terminal to run backup bash file

1. The user changes directory to the directory where the backup bash file exists

	  
2. The user enters the following command in the terminal :

	  	./backup.sh dir backupdir interval_secs max_backups
(where the user replaces dir backupdir interval_secs max_backups with the path of the directory to be backed up, path of directory to back up to, time to wait betweeen each check on the source directory status and the maximum number of back up directories respectively)



	  

Option 2 : using the Makefile

1. The user changes directory to the directory where the make file exists

2. User opens terminal

3. User enters this command  to backup the directroy
```
make
```
4. User can enter this command later to remove the backup directory
```
make clean
```

		  

	   





# END
