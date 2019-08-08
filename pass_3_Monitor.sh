#!/bin/bash
p=`awk '/Failed/{ip[$11]++}END{for (i in ip){print i","ip[i]}}' /var/log/secure `
for i in $p
do
   p=${i%,*}      #从后往前删除最后一个逗号前面所有的内容.
   n=${i#*,}      #从前往后删除最后一个逗号前面所有的内容
   [ $n -gt 3 ] && echo "报警!$p访问本机失败了$n次,请尽快处理"
done
