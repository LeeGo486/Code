
echo "********clear  environment of oracle*************"
userdel -rf oracle
groupdel  oinstall
groupdel dba

echo "********back sysctl.conf¡¢limits.conf¡¢login*************"
  cp -i  env_file_bak/sysctl.conf  /etc/sysctl.conf
  cp -i  env_file_bak/limits.conf  /etc/security/limits.conf
  cp -i  env_file_bak/login  /etc/pam.d/login 

echo "********add  group oinstall and dba ,add oracle user*************"
groupadd oinstall
groupadd dba

sudo mkdir  /app/tmp_install
sudo chmod -R a+xwr /app/tmp_install


# mkdir /app/femas
useradd  -m -g oinstall -G dba -d /app/femas oracle
passwd oracle

mkdir /app/femas/oracle
chown -R oracle:oinstall /app/femas/oracle
chmod -R 777 /app/femas/oracle


 mkdir env_file_bak
  cp -i /etc/sysctl.conf env_file_bak/
  cp -i /etc/security/limits.conf env_file_bak/
  cp -i /etc/pam.d/login env_file_bak/
  
  #kernel.shmmax = 68719476736

# Controls the maximum number of shared memory segments, in pages
#kernel.shmall = 68719476736
#kernel.shmmax = 68719476736


  
echo "********write /etc/sysctl.conf****in bytes****"
#echo "kernel.shmall = 68719476736" >> /etc/sysctl.conf
echo "kernel.shmmax =  5294967296" >> /etc/sysctl.conf
echo "kernel.shmmni = 4096" >> /etc/sysctl.conf
echo "kernel.sem = 250 32000 100 128" >> /etc/sysctl.conf
echo "fs.file-max = 65536" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 1024 65000" >> /etc/sysctl.conf
echo "net.core.rmem_default = 4194304" >> /etc/sysctl.conf
echo "net.core.rmem_max = 4194304" >> /etc/sysctl.conf
echo "net.core.wmem_default = 262144" >> /etc/sysctl.conf
echo "net.core.wmem_max = 262144" >> /etc/sysctl.conf

/sbin/sysctl -p
 echo "********write /etc/security/limits.conf*************"
echo "oracle soft nofile 1024" >> /etc/security/limits.conf
echo "oracle hard nofile 65536" >> /etc/security/limits.conf
echo "oracle soft nproc 2047" >> /etc/security/limits.conf
echo "oracle hard nproc 65536" >> /etc/security/limits.conf

echo "********write /etc/pam.d/login*************"
echo "session required /lib/security/pam_limits.so" >> /etc/pam.d/login
echo "session required pam_limits.so" >> /etc/pam.d/login

echo "********oracle .bash_profile*************"

#echo 'umask 022'>>/app/femas/.bash_profile
echo 'TMP=/app/tmp_install'>>/app/femas/.bash_profile
echo 'TMPDIR=/app/tmp_install' >>/app/femas/.bash_profile
echo 'export TMP TMPDIR' >>/app/femas/.bash_profile
echo 'export ORACLE_BASE=/app/femas/oracle'>>/app/femas/.bash_profile
echo 'export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1' >> /app/femas/.bash_profile

echo 'export PATH=$PATH:$ORACLE_HOME/bin'>> /app/femas/.bash_profile
echo 'export PATH=.:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$ORACLE_HOME/jdk/bin:$PATH'>> /app/femas/.bash_profile

echo 'export ORACLE_SID=orabiz'>> /app/femas/.bash_profile

echo 'export ORACLE_TERM=xterm'>>/app/femas/.bash_profile

echo 'export LIBPATH=$LIBPATH:$ORA_CRS_HOME/lib:$ORACLE_HOME/lib'>>/app/femas/.bash_profile
echo 'export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK' >> /app/femas/.bash_profile
echo 'export LANG=AMERICAN_AMERICA.ZHS16GBK' >> /app/femas/.bash_profile
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib:.' >> /app/femas/.bash_profile

