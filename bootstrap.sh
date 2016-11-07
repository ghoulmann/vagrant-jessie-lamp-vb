#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords

PASSWORD='root123'

# update / upgrade
sudo apt-get update
sudo apt-get -y --force-yes upgrade

# Install Packages
sudo apt-get -y --force-yes install curl apache2 php5 php5-curl php-pear php5-gd imagemagick screen tmux vim curl git

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get install -y --force-yes mysql-server php5-mysql

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get install -y --force-yes phpmyadmin

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
service apache2 restart

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
