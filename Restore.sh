NAME=$(find Backup -type f -mtime 1 \;)

sudo systemclt stop neard
echo "Near Node was stopped" | ts
if [ -d "$NAME"]; then
echo "Restore started" | ts


tar -xzvf $NAME.tar.gz
rm -rf /root/.near/data
cp -rf $NAME/data   /root/.near/
curl -fsS -m 10 --retry 5 -o /dev/null  https://hc-ping.com/79903c6a-0367-4b4d-9ad0-4687ea830563
echo "Restore completed" | ts
else
 echo $NAME is not found
 exit 0
fi
sudo systemctl start neard

echo "NEAR node was started" | ts

