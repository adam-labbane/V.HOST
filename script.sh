#!/bin/bash


echo 	"-----------------------------"
echo 	"-----------------------------"
echo	"--------\033[31m SCRIPT BASH \033[0m--------"
echo 	"-----------------------------"
echo 	"-----------------------------"
echo "\n"

echo "- Tapez * pour quittez le script\n"


vhost()
{ 
	echo "<VirtualHost *:80>
	ServerAdmin admin@$1.com
	ServerName $1.com
	ServerAlias www.$1.com
	DocumentRoot /var/www/$1.com/sitehtml
	ErrorLog \${APACHE_LOG_DIR}/error.log
	CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >> /etc/apache2/sites-available/$1.conf

}


nbr="a"
name="b"
n=1

#chmod -R 755 "/var/www"


while [ $nbr != "*" -o $name != "*" ]
do
	echo "Combien de VHOST voulez-vous creer ? : \c"
	read nbr
	while [ $nbr -gt 0 ]
	do
		echo "Entrer le nom de domaine numéro $n: \c"
		read name
		mkdir -p "/var/www/$name.com/sitehtml"
		vhost "$name"
		a2ensite $name.conf
		echo "192.168.27.148 $name.com" >> /etc/hosts
		nbr=$(($nbr-1))
		n=$(($n+1))
	done
done
a2dissite 000-default.conf
systemctl restart apache2
