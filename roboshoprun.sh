#!/bin/bash

USER_ID=$(id -u)

DNS_NAME="devops143.tk"

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
  useradd roboshop 2>&1 > /dev/null
  Status_Check
  fi
}

FRONTEND () {
  Print "Installing Nginx"
  yum install nginx -y
  Status_Check
  systemctl enable nginx
  systemctl start nginx
  Status_Check
  Print "Downloading frontend app"
  curl -s -L -o /tmp/$1.zip "$2"
  Status_Check
  cd /usr/share/nginx/html
  rm -rf *
  unzip -o /tmp/$1.zip
  Status_Check
  mv static/* .
  rm -rf static README.md
  mv template.conf /etc/nginx/nginx.conf
  export CATALOGUE=catalogue.${DNS_DOMAIN_NAME}
  export CART=cart.${DNS_DOMAIN_NAME}
  export USER=user.${DNS_DOMAIN_NAME}
  export SHIPPING=shipping.${DNS_DOMAIN_NAME}
  export PAYMENT=payment.${DNS_DOMAIN_NAME}
  if [ -e /etc/nginx/nginx.conf ]; then
    sed -i -e "s/CATALOGUE/${CATALOGUE}/" -e "s/CART/${CART}/" -e "s/USER/${USER}/" -e "s/SHIPPING/${SHIPPING}/" -e "s/PAYMENT/
    ${PAYMENT}/" /etc/nginx/nginx.conf
  fi
  Print "Starting Nginx"
  systemctl enable nginx
  systemctl restart nginx
  Status_Check
}

case $1 in
  frontend)
  FRONTEND "frontend" "https://dev.azure.com/DevOps-Batches/ce99914a-0f7d-4c46-9ccc-e4d025115ea9/_apis/git/repositories/db389ddc-b576-4fd9-be14-b373d943d6ee/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
  ;;
esac


