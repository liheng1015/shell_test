#!/bin/bash
case $1 in
"active")
curl -s http://192.168.2.100/status | awk 'NR==1{print $3}';;
"accep")
curl -s http://192.168.2.100/status | awk 'NR==3{print $1}';;
"waiting")
curl -s http://192.168.2.100/status | awk 'NR==4{print $6}';;
esac
