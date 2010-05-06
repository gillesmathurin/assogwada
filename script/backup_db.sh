#!/bin/bash
BACKUP_DIR = "~/backup/"
DATABASE=$1
USERNAME=$2
PASSWORD=$3
DUMP_FILE=$4x

cd BACKUP_DIR
/usr/bin/mysqldump -h localhost $DATABASE -u $USERNAME -p $PASSWORD > $DUMP_FILE
/usr/bin/gzip $DUMP_FILE
rm $DUMP_FILE