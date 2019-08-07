    #uptime                    //查看CUP负载
    #ifconfig eth0             //查看网卡流量
    #free                      //查看内存信息
    #df -h                     //查看磁盘空间
    #wc -l | /etc/passwd       //查看计算机账户数量
    #who |wc -l                //查看登录账户数量
    #rpm -qa |wc -l            //查看已安装软件包安装数量
#!/bin/bash  
while :
do
echo "#################################监控开始#####################################"
####################################查看cpu平局负载######################################
uptime | awk '{print "输出cpu平均负载是:"$8,$9,$10}'
####################################查看网卡接收的数据流量###############################
ifconfig eth0 | awk '/RX p/{print "网卡接收的流量是"$5"字节"}'
####################################查看主机剩余内存#####################################
free -m| awk '/^Mem/{print "主机剩余内存为"$4"M"}'
####################################查看主机硬盘剩余空间#################################
df -h | awk '/\/$/{print "硬盘剩余空间是"$4}'
####################################查看主机拥有账户数量#################################
awk '{x++}END{print "主机拥有的账户总数量为"x"个"}' /etc/passwd
#或a=$(cat /etc/passwd | wc -l) echo "主机拥有的账户总数量为$a个"
####################################查看主机登录账户数量#################################
x=`who | wc -l`
echo "当前登录的账户数量是$x"
####################################查看当前主机安装软件报数量###########################
p=`rpm -qa | wc -l`
echo "当前已安装的软件包数量为$p个"
####################################查看主机运行的进程数#################################
ps=`ps aux | wc -l`
echo "主机运行的进程为$ps个"
echo "#################################监控结束#####################################"
sleep 10
clear
done
