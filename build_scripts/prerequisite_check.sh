#!/bin/bash
#
#ejc-01.06.2024
#Last updated: 06.04.2024
#Check preqrequisites
echo "Checking Prerequisites..."
echo -ne '[=                    ](0%)\r'
if rpm -qa | grep "which" 1> /dev/null ; then
	echo -ne '[==                   ](5%)\r'
else
	echo "Which not found...install Which and come back later..."
	exit
fi
if rpm -qa | grep "sed" 1> /dev/null ; then
	echo -ne '[====                 ](10%)\r'
else
	echo "sed not found...install sed and come back later..."
	exit
fi
if rpm -qa | grep "make" 1> /dev/null ; then
	echo -ne '[====                 ](15%)\r'
else
	echo "make not found...install make and come back later..."
	exit
fi
if rpm -qa | grep "binutils" 1> /dev/null ; then
	echo -ne '[=====                ](20%)\r'
else
	echo "binutils not found...install binutils and come back later..."
	exit
fi
if rpm -qa | grep "gcc" 1> /dev/null ; then
	echo -ne '[======               ](25%)\r'
else
	echo "gcc not found...install gcc and come back later..."
	exit
fi
if rpm -qa | grep "gcc-c++" 1> /dev/null ; then
	echo -ne '[=======              ](30%)\r'
else
	echo "gcc-c++ not found...install gcc-c++ and come back later..."
	exit
fi
if rpm -qa | grep "bash" 1> /dev/null ; then
	echo -ne '[========             ](35%)\r'
else
	echo "bash not found...install bash and come back later..."
	exit
fi
if rpm -qa | grep "patch" 1> /dev/null ; then
	echo -ne '[=========            ](40%)\r'
else
	echo "patch not found...install patch and come back later..."
	exit
fi
if rpm -qa | grep "gzip" 1> /dev/null ; then
	echo -ne '[==========           ](45%)\r'
else
	echo "gzip not found...install gzip and come back later..."
	exit
fi
if rpm -qa | grep "bzip2" 1> /dev/null ; then
	echo -ne '[===========          ](50%)\r'
else
	echo "bzip2 not found...install bzip2 and come back later..."
	exit
fi
if rpm -qa | grep "perl" 1> /dev/null ; then
	echo -ne '[============         ](55%)\r'
else
	echo "perl not found...install perl and come back later..."
	exit
fi
if rpm -qa | grep "tar" 1> /dev/null ; then
	echo -ne '[=============        ](60%)\r'
else
	echo "tar not found...install tar and come back later..."
	exit
fi
if rpm -qa | grep "cpio" 1> /dev/null ; then
	echo -ne '[==============       ](65%)\r'
else
	echo "cpio not found...install cpio and come back later..."
	exit
fi
if rpm -qa | grep "unzip" 1> /dev/null ; then
	echo -ne '[==============       ](65%)\r'
else
	echo "unzip not found...install unzip and come back later..."
	exit
fi
if rpm -qa | grep "rsync" 1> /dev/null ; then
	echo -ne '[===============      ](70%)\r'
else
	echo "rsync not found...install rsync and come back later..."
	exit
fi
if rpm -qa | grep "file" 1> /dev/null ; then
	echo -ne '[===============      ](70%)\r'
	if [ "`which file`" == /usr/bin/file ]; then
		echo -ne '[================     ](75%)\r'
else
	echo "file not found...install file and come back later..."
	echo "file must be in /usr/bin/file"
	exit
fi
fi
if rpm -qa | grep "bc" 1> /dev/null ; then
	echo -ne '[=================    ](80%)\r'
else
	echo "bc not found...install bc and come back later..."
	exit
fi
if rpm -qa | grep "wget" 1> /dev/null ; then
	echo -ne '[==================   ](85%)\r'
else
	echo "wget not found...install wget and come back later..."
	exit
fi
if rpm -qa | grep "python" 1> /dev/null ; then
	echo -ne '[===================  ](90%)\r'
else
	echo "python not found...install python and come back later..."
	exit
fi
if rpm -qa | grep "ncurses" 1> /dev/null ; then
	echo -ne '[==================== ](95%)\r'
else
	echo "ncurses packages not found...install ncurses and come back later..."
	exit
fi
if rpm -qa | grep "qt5" 1> /dev/null ; then
	echo -ne '[=====================](97%)\r'
else
	echo "qt5 packages not found...install qt5 and come back later..."
	exit
fi
if rpm -qa | grep "perl-ExtUtils-MakeMaker" 1> /dev/null ; then
	echo -ne '[=====================](99%)\r'
else
	echo "perl-ExtUtils-MakeMaker packages not found...install perl-ExtUtils-MakeMaker and come back later..."
	exit
fi
if rpm -qa | grep "perl-FindBin" 1> /dev/null ; then
	echo -ne '[=====================](99%)\r'
else
	echo "perl-FindBin packages not found...install perl-FindBin and come back later..."
	exit
fi
if rpm -qa | grep "perl-Thread" 1> /dev/null ; then
	echo -ne '[=====================](99%)\r'
else
	echo "perl-Thread packages not found...install perl-Thread and come back later..."
	exit
fi
if rpm -qa | grep "perl-Thread-Queue" 1> /dev/null ; then
	echo -ne '[=====================](99%)\r'
else
	echo "perl-Thread-Queue packages not found...install perl-Thread-Queue and come back later..."
	exit
fi
if rpm -qa | grep "perl-English" 1> /dev/null ; then
	echo -ne '[=====================](99%)\r'
else
	echo "perl-English packages not found...install perl-English and come back later..."
	exit
fi
if rpm -qa | grep "perl-IPC-Cmd" 1> /dev/null ; then
	echo -ne '[=====================](99%)\r'
else
	echo "perl-IPC-Cmd packages not found...install perl-IPC-Cmd and come back later..."
	exit
fi
if rpm -qa | grep "gtk2" 1> /dev/null ; then
	echo -ne '[=====================](100%)\r'
else
	echo "gtk2 packages not found...install gtk2 and come back later..."
	exit
fi
echo -ne '\n'
echo "Prerequisites check finished. If you made it here you're good!"
