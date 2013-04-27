#!/bin/sh
#
# Dark Future Colorizer
#
# Authors:       Claudio (CoD) Canavese  <cod@cod-web.net>
# Version:       0.1
# Description:   Automagically colorize the Dark Future KDE 4 icon theme creating a new theme
# Last modified: 2010/09/06
#
# Changelog:
#  0.1            first version of this wonderful script
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

echo "Dark Future Colorizer"
echo "Versione 0.1"
echo "Claudio CoD Canavese <cod@cod-web.net>"
echo
echo "This script let's you colorize the Dark Future KDE 4 icon theme."
echo "It will NOT overwrite the original files: a new theme will be created."
echo
echo -n  "Shall we proceed? [y/N]"
read proceed
if [ "$proceed" != 'y' ]
then
  echo
  echo "Aborting."
  exit
fi

clear
echo "Please insert the new HEX color for the theme (6 characters, no # symbol needed)"
echo "or nothing to abort."
echo -n "New color: "
read newcolor
if [ "$newcolor" = '' ]
then
  echo
  echo "No color specifed: aborting."
  exit
fi

clear
echo "Please insert the new name for this theme (for example: Red Future, My Dark Future, etc...)"
echo "or nothing to abort."
echo -n  "New name: "
read newname
if [ "$newname" = '' ]
then
  echo
  echo "No name specifed: aborting."
  exit
fi

clear
echo "Please insert the new folder for this theme or nothing to abort."
echo -n  "New folder: "
read newfolder
if [ "$newfolder" = '' ]
then
  echo
  echo "No folder specifed: aborting."
  exit
fi

clear
echo "A new theme will now be created."
echo "The new foreground color will be ${newcolor}"
echo "The new theme name will be ${newname}"
echo "The new theme folder will be ${newfolder}"
echo
echo -n  "Proceed? [y/N]"
read proceed
if [ "$proceed" != 'y' ]
then
  echo
  echo "Aborting."
  exit
fi

mylocation=`pwd`
cd ..
cp -r "${mylocation}" "${newfolder}/"
cd "${newfolder}"
perl -pi -e "s/DarkFuture/${newname}/g" index.theme
cd scalable
rename 's/\.svgz/\.svg\.z/' */*.svgz
for iconfile in `ls */*.z`
do
	gunzip $iconfile
done
perl -pi -e "s/#d3cdc5/#${newcolor}/gi" */*.svg
gzip -S z */*.svg
