#!/bin/bash

echo "Checking and installing composer (PHP)"

packages=./packages.txt

if php -v > /dev/null; then
	echo "PHP is already installed"
	if composer -v > /dev/null; then
		echo "composer is already installed"
		if [ -e "$packages" ]; then
			echo "File - packages.txt - exists"
				echo "First: Install the global package - laravel/installer"
				composer global require "laravel/installer"
				echo "Try to install all packages from txt - file"
			while read -r line
			do
				app=`echo $line | cut -d \; -f 1`
				composer require $app
			done < $apps
		else
			echo "File not exists"
			echo "Create or update your file and run again"
		fi
	else
		echo "composer is not installed"
	fi
else
	echo "Nothing works ?!"
	echo "Next step: Install composer"
	if php -v > /dev/null; then
		php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
		# php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
		php composer-setup.php
		php -r "unlink('composer-setup.php');"
	fi
	echo "Next step: Move 'composer' to /usr/local/bin/"
	mv composer.phar /usr/local/bin/composer
	echo "Next step: Remove 'composer-setup.php'"
	rm composer-setup.php
	echo "Finally step: Install packages"
	if [ -e "$packages" ]; then
		echo "File - packages.txt - exists"
			echo "First: Install the global package - laravel/installer"
			composer global require "laravel/installer"
			echo "Try to install all packages from txt - file"
		while read -r line
		do
			app=`echo $line | cut -d \; -f 1`
			composer require $app
		done < $apps
	else
		echo "File not exists"
		echo "Exit process"
		exit 1
	fi
fi
