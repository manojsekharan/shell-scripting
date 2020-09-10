#!/bin/bash

USERID=$(id -u)

case $USER_ID in
0)
  echo "Starting installation"
  ;;
1)
  echo -e "\e[32mYou should be root user to perform this script[0m"
  ;;
exit 1
esac