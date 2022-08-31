NAME=$(find Backup -type f -mtime 1 \;)

sudo systemclt stop neard
echo "Near Node was stopped" | ts
if [ -d "$NAME"]; then
echo "Restore started" | ts


tar -xzvf $NAME.tar.gz
rm -rf /root/.near/data
cp -rf $NAME/data   /root/.near/

echo "Restore completed" | ts
else
 echo $NAME is not found
 exit 0
fi
sudo systemctl start neard

echo "NEAR node was started" | ts

