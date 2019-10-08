#!/bin/bash
a=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
for i in {1..8}
do
x=$[RANDOM%62]
pass=${a:x:1}
pass2=$pass2$pass
done
echo $pass2
