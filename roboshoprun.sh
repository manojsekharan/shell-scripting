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

if [ $USER_ID -eq 0 ]; then
  echo -e  "\e[33mStarting installation\e[0m"
else
  echo -e "\e[33mYou have to be root to execute the command\e[0m"
fi

Print (){
  echo -e "\e[33m>>>>>>>>>$1>>>>>\e[0m"
}

Status_Check () {
  case $? in
  0)
  echo -e "\e[33mSUCCESSFUL\e[0m"
  ;;
  *)
  echo -e "\e[1;31mFailure\e[0m"
  ;;
  esac
}

Create_user (){
  id roboshop
  if  [ $? -ne 0 ]; then
  Print "Application user added"
  useradd roboshop
  Status_Check
  fi
}

Create_user


