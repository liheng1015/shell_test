#!/bin/bash
path="/usr/local/nginx/conf"
###########################################设置动静分离网站#################################################

#-------------------------1.安装依赖包设置nginx源码包安装,并设置开机自启------------------------------
yum -y install gcc pcre-devel openssl-devel 
cd /opt/
tar -xf lnmp_soft.tar.gz
cd lnmp_soft
tar -xf nginx-1.12.2.tar.gz 
cd nginx-1.12.2/
useradd -s /sbin/nologin nginx
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module --with-http_stub_status_module
make && make install
sleep 2
/usr/local/nginx/sbin/nginx   #---启动nginx
sleep 2
echo ""
echo ""
ss -anptu | grep nginx        #---查看nginx状态
echo ""
echo ""
sleep 2
echo "/usr/local/nginx/sbin/nginx" >> /etc/rc.local   #---nginx设置开机自启
chmod +x /etc/rc.local

#--------------------------2.启动MariaDB、FPM服务---------------------------------------------------------
yum -y install   mariadb   mariadb-server   mariadb-devel
yum -y install   php        php-mysql        php-fpm
systemctl start   mariadb
systemctl enable  mariadb
 systemctl start  php-fpm
systemctl enable php-fpm

#-------------------------3.修改Nginx配置文件，实现动静分离---------------------------------------------
sed -i 's/index  index.html index.htm/index  index.php index.html index.htm/' $path/nginx.conf
sed -i '65,71s/#//' $path/nginx.conf
sed -i '/SCRIPT_FILENAME/d' $path/nginx.conf
sed -i 's/fastcgi_params/fastcgi.conf/' $path/nginx.conf
/usr/local/nginx/sbin/nginx -s reload 
#sed 's/^/#/' /usr/local/nginx/conf/nginx.conf | awk '/SCRIPT_FILENAME/'
