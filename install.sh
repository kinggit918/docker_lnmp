#!/bin/bash
adduser admin
groupadd docker
usermod -a -G docker admin
tar xzvf lnmp.tar.gz -C /home/admin
cd /home/admin
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install device-mapper-libs docker-io
service docker start
cd lnmp/
./create_images.sh
./start_lnmp.sh

num=`iptables -nL --line-number | grep REJECT | sed -n '2p' | awk '{print $1}'`
iptables -I  FORWARD $num -i docker0 -o docker0 -j ACCEPT

cat  <<EOF > /var/www/html/test.php
<?php
//date
echo date("Y-m-d H:i:s")."<br />\\\\n";

//mysql
try {
\$conn = new PDO('mysql:host=mysql;port=3306;dbname=mysql;charset=utf8', 'root', 'dockertest');
} catch (PDOException \$e) {
echo 'Connection failed: ' . \$e->getMessage();
}
//\$conn->exec('set names utf8');
\$sql = "SELECT * FROM \`user\` WHERE 1";
\$result = \$conn->query(\$sql);
while(\$rows = \$result->fetch(PDO::FETCH_ASSOC)) {
echo \$rows['Host'] . ' ' . \$rows['User']."<br />\\\\n";
}

//phpinfo
phpinfo();
?>
EOF

curl http://127.0.0.1/test.php
