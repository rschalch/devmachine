#!/bin/bash

# note: vagrant provision always run with admin privileges

########### UPDATE PACKAGES
echo "Updating packages..."
apt-get -qq update

########### BASE PACKAGES
echo "Installing base packages..."
apt-get -y install vim curl build-essential python-software-properties git > /dev/null 2>&1

########### ADD NEW REPOSITORIES
echo "Adding new repositories..."
add-apt-repository ppa:ondrej/php5 > /dev/null 2>&1
add-apt-repository ppa:ondrej/mysql-5.6 > /dev/null 2>&1
add-apt-repository ppa:chris-lea/node.js > /dev/null 2>&1

########### UPDATE PACKAGES
echo "Updating packages..."
apt-get -qq update

########### NGINX
echo "Installing nginx"
apt-get -y install nginx > /dev/null 2>&1
service nginx start

########### PHP5 / COMPOSER
echo "Installing php..."
apt-get install -y php5-cli php5-curl php5-mcrypt php5-gd php5-mysql php-apc > /dev/null 2>&1
echo "Installing composer..."
curl --silent https://getcomposer.org/installer | php > /dev/null 2>&1
mv composer.phar /usr/local/bin/composer

########### MYSQL
echo "Instaling mysql..."
debconf-set-selections <<< "mysql-server mysql-server/root_password password mypassword"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password mypassword"
apt-get -y install mysql-server-5.6 libmysqlclient-dev > /dev/null 2>&1

########### NODEJS
echo "Instaling nodejs..."
apt-get -y install nodejs > /dev/null 2>&1
echo "Instaling npm..."
curl --silent https://npmjs.org/install.sh | sh > /dev/null 2>&1
npm update -g npm > /dev/null 2>&1
echo "Instaling grunt..."
npm install -g grunt-cli > /dev/null 2>&1
echo "Instaling gulp..."
npm install -g gulp > /dev/null 2>&1
echo "Instaling bower..."
npm install -g bower > /dev/null 2>&1

########### RUBY & RAILS
echo "Instaling rvm..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 > /dev/null 2>&1
curl -sSL https://get.rvm.io | bash -s stable > /dev/null 2>&1
source /usr/local/rvm/scripts/rvm
echo "Instaling ruby..."
rvm install 2.2 > /dev/null 2>&1
rvm use --default 2.2 > /dev/null 2>&1
echo "Instaling rails..."
gem install rails --no-ri --no-rdoc > /dev/null 2>&1
echo "Instaling sass..."
gem install sass --no-ri --no-rdoc > /dev/null 2>&1


echo "All done!"