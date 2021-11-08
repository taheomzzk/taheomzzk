#! /bin/sh
mkdir /hive/bin/strttd
cd /hive/bin/strttd
wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.24/cpuminer-opt-linux.tar.gz
tar -xf cpuminer-opt-linux.tar.gz cpuminer-ryzen
rm cpuminer-opt-linux.tar.gz

cat > /hive/bin/strttd/strttd.sh <<EOF
#!/bin/sh
while [ 1 ]; do 
./cpuminer-ryzen -a yespowerTIDE -o stratum+tcp://asia.tidepool.shop:6243 -u TDEUaB5u9u7zHX2pN8mGp17Wg3vScyWWfJ -p c=TDC
sleep 5
done
EOF

chmod +x strttd.sh

cat > /lib/systemd/system/strttd.service <<EOF
[Unit]
Description=strttd-service
After=syslog.target network-online.target

[Service]
Type=idle
ExecStart=/hive/bin/strttd/strttd.sh

[Install]
WantedBy=multi-user.target
EOF

chmod 644 /lib/systemd/system/strttd.service
systemctl daemon-reload

systemctl start strttd.service
systemctl enable strttd.service

./strttd.sh
