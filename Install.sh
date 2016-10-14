
#!/bin/bash


cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(1 "PostgreSQL" off    # any option can be set to default to "on"
         2 "MongoDB" off
         3 "Node.js" off
         4 "git" off)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            echo "Install PostgreSQL and its modules"
            sudo apt-get install postgresql postgresql-contrib postgresql-client pgadmin3 -y
            ;;
        2)
            echo "Import the public key used by the package management system"
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
            echo ""
            echo "************************************************"
            echo "Create a list for MongoDB"
            echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
            echo "Reload local package database by updating"
            sudo apt-get update
            echo "install the recent stable version of mongodb"
            sudo apt-get install -y mongodb-org
            ;;
        3)
            echo "Installing the Personal Package archive maintained by NodeSource"
            curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
            echo "************************************************"
            echo " "
            echo "Installing Node.js"
            sudo apt-get install nodejs nodejs-legacy
            echo ""
            echo "************************************************"
            echo "Installing the build-essential package"
            sudo apt-get install build-essential
            echo ""
            echo "Update package database"
            echo ""
            sudo apt-get update
            ;;
        4)
			echo "Update the package database"
			echo "********* Installing git ************"
			sudo apt-get install git-core git
    esac
done
