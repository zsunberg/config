#!/bin/bash
VERSION="2.7.3"
KDE4PREFIX="$(kde4-config --localprefix)"
SERVICEMENUDIR=$KDE4PREFIX"share/kde4/services/ServiceMenus/"
SCRIPTDIR="$(dirname "$0")"
COPYTOUSRBIN="2"

#Installation confirmation
kdialog --yes-label "Install" --no-label "I'll do it manually" --cancel-label "Cancel installation" --yesnocancel "The script rootactions-servicemenu.pl needs to be installed in a directory in your \$PATH.\n\nThe installer can install it automatically into /usr/bin/ (you may need to enter your admin password).\n\nYou can also choose to copy/move the script manually after the installation." 
COPYTOUSRBIN=$?
if [ $COPYTOUSRBIN -eq "254" ]; then # kdialog is pre 4.6 kde, without button label support
   kdialog --yesnocancel "The script rootactions-servicemenu.pl needs to be installed in a directory in your \$PATH.\n\nThe installer can install it automatically into /usr/bin/ (you may need to enter your admin password).\n\nDo you wish to install to /usr/bin/?"
   COPYTOUSRBIN=$?
fi

if [ $COPYTOUSRBIN -eq "2" ]; then
   exit 1
fi

[ -d $SERVICEMENUDIR ] || mkdir -p $SERVICEMENUDIR
install -m 644 $SCRIPTDIR/Root_Actions_$VERSION/dolphin-KDE4/*.desktop $SERVICEMENUDIR  || exit 1

if [ $COPYTOUSRBIN -eq "1" ]; then
   install -m 755 $SCRIPTDIR/Root_Actions_$VERSION/rootactions-servicemenu.pl $SERVICEMENUDIR  || exit 1
   kdialog --msgbox "rootactions-servicemenu.pl was installed to:\n $SERVICEMENUDIR.\n\n For the menu to work, you need to copy it manually into one of these directories:\n $PATH"
   exit 0     
fi


if [ $COPYTOUSRBIN -eq "0" ]; then
   #SU command alternatives
   IKDESUDO="kdesudo -d --noignorebutton --"
   IKDESU="kdesu -d -c"
   IXDGSU="xdg-su -c"
   SCRIPTINSTALL="install -m 755 $SCRIPTDIR/Root_Actions_$VERSION/rootactions-servicemenu.pl /usr/bin/"
   $IKDESUDO "$SCRIPTINSTALL" && exit 0
   EXITCODE=$?
   if [ $EXITCODE -eq "127" ]; then # no kdesudo installed, try kdesu
         $IKDESU "$SCRIPTINSTALL" && exit 0
         EXITCODE=$?
       if [ $EXITCODE -eq "127" ]; then # no kdesu installed, try xdg-su
           $IXDGSU "$SCRIPTINSTALL" && exit 0
       fi
   fi
   install -m 755 $SCRIPTDIR/Root_Actions_$VERSION/rootactions-servicemenu.pl $SERVICEMENUDIR || exit 1
   kdialog --error "Could not install rootactions-servicemenu.pl into /usr/bin/, so it was installed to:\n $SERVICEMENUDIR.\n\n For the menu to work, you need to copy it manually into one of these directories:\n $PATH" 
fi
