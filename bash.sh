#!/bin/bash
#chennailuan's function


#check last command id Ok or not.
check_ok(){
	if [ $? != 0 ]
	then 
		echo Error,Check the error log.
		exit 1
	fi
}

#if the packge installed ,then omit
myum(){
	if ! rpm -qa|grep -q "^$1"
	then 
		yum install -y $1
		check_ok
	else
		echo $1 already installed.
	fi
}

#check service is running or not ,example nginx ,httpd ,php-fpm
check_service(){
	if [ $1 == "phpfpm" ]
	then
		s="php-fpm"
	else
		s=$1
  	fi
	
	n=`ps aux | grep $s | wc -l`
	if [ $n -gt 1 ]
	then
		echo "$1 service is already started."
	else 
		if [ -f /etc/init.d/$1 ]
		then
			/etc/init.d/$1 start
			check_ok
		else
			install_$1
 		fi
	fi
}
