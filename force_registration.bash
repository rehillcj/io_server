#!/bin/bash


#echo $1
mosquitto_pub -h 192.168.6.30 -t arduino/$1/in/register -m register