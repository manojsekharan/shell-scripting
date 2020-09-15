#!/bin/bash

USER_ID=$(id -u)

#case $USER_ID in
#    0)
#     echo -e "\e[33mStarting installation\e[0m"
#    ;;
#    *)
#      echo -e "\e[1;31mYou have to be root to execute the command\e[0m"
#    ;;
#    esac

if [ USER_ID -eq 0 ]; then
  echo -e  "\e[33mStarting installation\e[0m"
else
  echo -e "\e[33mYou have to be root to execute the command\e[0m"
fi



