#!/bin/bash

# Init Script for WordPress and WooCommerce Website
echo "Setting up WP and WooCommerce E-Commerce Platform base"

echo "Creating a database for the project (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS bmwc_dev"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON bmwc_dev.* TO wp@localhost IDENTIFIED BY 'wp';"

# Check for the presence of a `htdocs` folder.
if [ ! -d htdocs ]
then
    echo "Creating web root folder: htdocs"
    mkdir htdocs
fi

cd htdocs

if [ ! -f "wp-config.php" ]
then
    echo "Downloading Wordpress Core"
    # Download and unzip latest version of WordPress
    wp core download --allow-root
    # Use WP CLI to create a `wp-config.php` file
    wp core config --dbname="bmwc_dev" --dbuser=wp --dbpass=wp --dbhost="localhost" --allow-root
    # Use WP CLI to install WordPress
    wp core install --url=bmwc.dev --title="Bossman Marketing WooCommerce & WP E-Commerce Platform" --admin_user="gjohnson" --admin_password="1nn3rB0t" --admin_email="greg@innerbot.com" --allow-root
    
    # use wp to change active theme to storefront-child
    wp theme update storefront --allow-root
    wp theme activate storefront-child --allow-root

    # use wp to activate all appropriate plugins
    wp plugin delete hello --allow-root
    wp plugin activate --all --allow-root
fi

# The Vagrant site setup script will restart Nginx for us

# Let the user know the good news
echo "WordPress Stable now installed for bwmc.dev";