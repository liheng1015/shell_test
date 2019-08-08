######################################开启vsftp的上传功能#################################
#!/bin/bash
yum -y install vsftpd &> /dev/dull
sed -i 's/^#anon_u/anon_u/' /etc/vsftpd/vsftpd.conf
systemctl restart vsftpd
systemctl enable vsftpd
chmod o+w /var/ftp/pub
