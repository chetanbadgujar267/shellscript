#####################################################################################################
#AuthorName:  Om Prakash
#AuthorEmail: om.a.prakash@ericsson.com
#CreatedOn:   Mar 22, 2017
#####################################################################################################
#This NRPE pluging will help out to find whether there is change in patch level.
#It will detect and notify when there is an upgrade/update/install/remove of any package/patch.

#OK:            If there is no change in current patch level.
#UNKNOWN:       If patch history has been cleared/deleted.
#CRITICAL:      If there is change in current patch level.
#####################################################################################################

#!/bin/bash
#set -x

#Defining exit status variables
STATUS_CRITICAL=2
STATUS_UNKWOWN=1
STATUS_OK=0

#Funtion to check Patch Level in Redhat/CentOS
PatchInfoRedhat () {

if [ -f /tmp/transactionID.txt ];then

  BTID=`cat /tmp/transactionID.txt` #BaseTransactionID
  CTID=`yum history stats|awk '/Transactions/{print $2}'` #CurrentTransactionID
  CIPL=$((CTID-BTID)) #ChangeInPatchLevel

  if [ $CIPL -gt 0 ];then
    echo -e "Critical! There is change in patch level." \
    "\nDescription of altered packages:" \
    "`for (( i=$((BTID+1)); i<=$CTID; i++ ));do echo "\n";yum history info $i|awk '{ORS="\t"}/User/ || /Command Line/{print $0}';done`" \
    "| PatchesChanged=$CIPL"
    echo "$CTID" > /tmp/transactionID.txt
    exit $STATUS_CRITICAL
  elif [ $CIPL -eq 0 ];then
    echo "OK! There is NO change in patch level. | PatchesChanged=$CIPL"
    exit $STATUS_OK
  else
    echo "Unknown! Old yum history has been cleared/deleted."
    echo "$CTID" > /tmp/transactionID.txt
    exit $STATUS_UNKWOWN
  fi

else
  yum history stats|awk '/Transactions/{print $2}' > /tmp/transactionID.txt
  chown op5nrpe:nfsnobody /tmp/transactionID.txt
  chmod 1664 /tmp/transactionID.txt
fi

}

#Funtion to check Patch Level in Ubuntu
PatchInfoUbuntu () {

LOGFILE="/var/log/dpkg.log"
DATE=`date +%Y-%m/-%d`
CIPL=0

if [ -f $LOGFILE ];then

  IsModified=`find $LOGFILE -mmin -30|wc -l`
  test $IsModified -gt 0 && CIPL=`grep $DATE $LOGFILE|awk '$3 ~ /install/ || $3 ~ /remove/ || $3 ~ /update/ || $3 ~ /upgrade/{print $0}'|wc -l`

  if [ $CIPL -gt 0 ];then
    echo -e "Critical! There is change in patch level." \
    "\n\nDescription of altered packages:\n`grep $DATE $LOGFILE|awk '$3 ~ /install/ || $3 ~ /remove/ || $3 ~ /update/ || $3 ~ /upgrade/{print $0}'`" \
    "| PatchesChanged=$CIPL"
    exit $STATUS_CRITICAL
  else
    echo "OK! There is NO change in patch level. | PatchesChanged=$CIPL"
    exit $STATUS_OK
  fi

else
  echo "Unknown! Old package history ($LOGFILE) has been cleared/deleted."
  exit $STATUS_UNKWOWN
fi

}

#Identifying OS Type
which facter 1> /dev/null 2>&1
if [ $? -eq 0 ]; then
  OS=`facter operatingsystem`
elif [ `ls /etc/*release|grep -ic redhat` -gt 0 ];then
  OS=RedHat
elif [ `ls /etc/*release|grep -ic cent` -gt 0 ];then
  OS=CentOS
elif [ `ls /etc/*release|grep -ic suse` -gt 0 ];then
  OS=SuSE
elif [ `cat /etc/*release|grep -ic ubuntu` -gt 0 ];then
  OS=Ubuntu
elif [ `uname -s` = "SunOS" ];then
  OS=Solaris
else
  OS=Unsupported
fi

#Calling Patch module as per OS Type
case "$OS" in
"RedHat"|"CentOS")
  PatchInfoRedhat
;;
"SuSE")
  PatchInfoSuse
;;
"Ubuntu")
  PatchInfoUbuntu
;;
"Solaris")
  PatchInfoSolaris
;;
"Unsupported")
  echo "Unknown! OS Unsupported."
  exit $STATUS_UNKWOWN
;;
esac
