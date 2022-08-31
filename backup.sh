DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR=/root/.near
BACKUPDIR=BackupNear/near_${DATE}

sudo mkdir $BACKUPDIR

sudo systemctl stop neard

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo " Delete Old File " | ts
        find BackupNear -type f -mtime 1 -exec rm -rf {} \;
    echo " Delete Done " | ts
    echo "Backup started" | ts
    cp -rf  $DATADIR/data/  ${BACKUPDIR}/

    tar -czvf ${BACKUPDIR}.tar.gz  ${BACKUPDIR}
    rm -rf ${BACKUPDIR}

    # Submit backup completion status, you can use healthchecks.io, betteruptime.com or other services
    # Example
     curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/adf6601b-22a3-4c47-aa4e-8341f536ad3f

    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard

echo "NEAR node was started" | ts

