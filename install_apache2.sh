#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo a2enmod rewrite
sudo a2enmod ssl
sudo /etc/init.d/apache2 restart
sudo mkdir /var/www/html/user
echo "<h1>This is sales Page in Apache II </h1>" > /var/www/html/user/index.html
sudo mkdir /var/www/html/dashboard
echo "<h1>This is Dash Board Page in Apache II </h1>" > /var/www/html/dashboard/index.html
