#!/bin/bash
KDE4PREFIX="$(kde4-config --localprefix)"
SERVICEMENUDIR=$KDE4PREFIX"share/kde4/services/ServiceMenus/"
FOLDERMENU="10-rootactionsfolders.desktop"
FILEMENU="11-rootactionsfiles.desktop"
SCRIPTFILE="rootactions-servicemenu.pl"
USRBINSCRIPTFILE="/usr/bin/"$SCRIPTFILE
REMOVAL="1"
DOWNLOADDIR=$KDE4PREFIX"share/apps/servicemenu-download/*rootactions_servicemenu.tar.gz-dir"

#check for script file installed in /usr/bin
if [ -f $USRBINSCRIPTFILE ]; then
   kdialog --yes-label "Remove it" --no-label "Leave it" --yesno "The script rootactions-servicemenu.pl was found in /usr/bin/.\n\nDo you wish to remove it (you may need to enter your admin password)?\n\nIt's a good idea to leave it if there are other users on your machine using the menu." 
   REMOVAL=$?
   if [ $REMOVAL -eq "254" ]; then # kdialog is pre 4.6 kde, without button label support
      kdialog --yesno "The script rootactions-servicemenu.pl was found in /usr/bin/.\n\nIt's a good idea to leave it if there are other users on your machine using the menu.\n\nRemove it? (you may need to enter your admin password)"
      REMOVAL=$?
   fi
fi

#remove files installed in ServiceMenus
rm $SERVICEMENUDIR$FOLDERMENU $SERVICEMENUDIR$FILEMENU $SERVICEMENUDIR$SCRIPTFILE

if [ $REMOVAL -eq "0" ]; then
   #SU command alternatives
   IKDESUDO="kdesudo -d --noignorebutton --"
   IKDESU="kdesu -d -c"
   IXDGSU="xdg-su -c"
   $IKDESUDO "rm $USRBINSCRIPTFILE"
   EXITCODE=$?
   if [ $EXITCODE -eq "127" ]; then # no kdesudo installed, try kdesu
         $IKDESU "rm $USRBINSCRIPTFILE"
         EXITCODE=$?
       if [ $EXITCODE -eq "127" ]; then # no kdesu installed, try xdg-su
           $IXDGSU "rm $USRBINSCRIPTFILE"
           EXITCODE=$?
       fi
   fi
   if [ $EXITCODE -ne "0" ]; then
      kdialog --error "Could not remove $USRBINSCRIPTFILE.\n\nPlease delete it manually to complete the uninstallation."   
   fi  
fi

if [ -d $DOWNLOADDIR ]; then
   rm -r $DOWNLOADDIR
fi