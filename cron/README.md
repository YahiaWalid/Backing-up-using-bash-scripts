# Backup Project (Cron Job part)

## Step by step user instruction
1. The user should open the terminal and change directory to the directory that contains the backup-cron .sh file.

2. The user should edit the backup-cron bash file with his source , destination directories paths and with the maximum number of backups or it will be set to 10 automatically

3. To create the cronjob the user should enter the following command
```
crontab -e
```

4. After entering the previous command, the user should enter the cron expression in order to have the cron job work every 1 minute
```
* * * * * /bin/bash /path/cron/backup-cron.sh
```
(where path is the path to the directory called cron that contains the bash file)

5. Now the user can check if the cron is enabled by entering the following command that lists the active crons
```
crontab -l
```

6. If the user wants to stop the cron job , the following command will be entered
```
crontab -e
```

7. From this command the user can either comment the cron job by adding a '#' sign or by removing the whole cron expression

## Prerequisites

It is preferred that the user's system is up to date. To update the system the following command can be used
```
sudo apt-get update
```
To run the bash file the user should make sure that it is executable by entering the following command
```
chmod +x backup-cron.sh
```
In order to use cron jobs, we need to check if cron service exists. 
```
sudo systemctl status cron.service
```
If it does not exist, the user can easily install it using the following command
```
sudo apt-get install cron
```
As for the Makefile to run it, the user should install the make package using
```
sudo apt install -y make
```
# Question

Q :What should be the cron expression if I need to run this backup every Friday which is the third day
of the month at 12:31 am ?

A: The cron expression will be
```
31 12 3 * 5 /bin/bash /path/cron/backup-cron.sh
```
31 : indicates that the cron will work every minute of value 31

12 : indicates that the cron will work every hour of value 12  (12 AM since input is in 24 hr format )

3  : indicates that the cron will work every day of date 3 each month

'*': indicates that the cron will work every month

5  : indicates that the cron will work every Friday

so by combining the above, the script will run every 12:31AM on every 3rd of Friday ONLY .

# END
