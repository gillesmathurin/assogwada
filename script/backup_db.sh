#!/bin/bash
# production
BACKUP_DIR=~/backup/
DATABASE=$1
USERNAME=$2
PASSWORD=$3
DUMP_FILE=$4

cd $BACKUP_DIR
mysqldump $DATABASE -u $USERNAME -password=$PASSWORD > $DUMP_FILE
gzip $DUMP_FILE

# development
# BACKUP_DIR=~/backup/
# DATABASE=$1
# USERNAME=$2
# # PASSWORD=$3
# DUMP_FILE=$3
# 
# cd $BACKUP_DIR
# mysqldump $DATABASE -u $USERNAME > $DUMP_FILE
# /usr/bin/gzip $DUMP_FILE
# # rm $DUMP_FILE
