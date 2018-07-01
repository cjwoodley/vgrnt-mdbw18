#!/bin/bash

echo "Hello World"
FILE=./mongodb-linux-x86_64-ubuntu1604-4.0.0.tgz
echo $FILE
if [ ! -e "$FILE" ]; then
		echo "MongoDB Needs to be downloaded"
		##wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-4.0.0.tgz
	else 
		echo  "MongoDB is downloaded already, moving to next step"
fi

prereq="libcurl3 openssl"
for pkg in $prereq; do
	if dpkg --get-selections | grep -q "^$prereq[[:space:]]*install$" >/dev/null; then
		echo -e "$prereq Packages are installed"
	else 
		if apt-get -qq install $prereq; then
			echo "Successfully installed $prereq"
		else
			echo "Error installing $prereq"
		fi
	fi
done


#Setup MongoDB
mongoDir=/opt/mongo
if [ ! -d $mongoDir ]; then 
	mkdir $mongoDir
else 
	echo -e "directory exist "
fi 

mongoTGZ=mongodb-linux-x86_64-ubuntu1604-4.0.0.tgz
mongoBin=$mongoDir/$mongoTGZ
if [ ! -f $mongoBin ]; then 
	cp $mongoTGZ $mongoBin
	echo -e "copied file to directory"
else 
	echo -e "file already exist: $mongoBin"
fi 

if [ -f $mongoBin ]; then 
	tar -zxvf mongodb-linux-*-4.0.0.tgz -C $mongoDir
	#export PATH=$mongoDir//bin:$PATH
fi
