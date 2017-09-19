#!/bin/bash
#  *****Z
#
# KODI CEC COMMANDS
#
# Author Nick Farrow
#
# Initial Release: 0

yourname="Nick"

# switch on TV
        ONZ()
        {
                echo "on 0" | cec-client -s|grep -v DEBUG|grep -v TRAFFIC
        }

# switch off TV
        OFFZ()
        {
                echo "tx 10 36" | cec-client -s|grep -v DEBUG|grep -v TRAFFIC
                # or
                #echo "tx F0 36" | cec-client -s|grep -v DEBUG|grep -v TRAFFIC
        }

# switch to raspberry source
        SWITCHZ()
        {
                echo "as" | cec-client -s
        }

# mute TV
        MUTEZ()
        {
                echo "7A" | cec-client -s|grep -v DEBUG|grep -v TRAFFIC
                #or
                echo "tx F0 44" | cec-client -s|grep -v DEBUG|grep -v TRAFFIC
        }

# mute TV
        STANDBYZ()
        {
                echo "36" | cec-client -s|grep -v DEBUG|grep -v TRAFFIC
        }

# INfo of device
        INFOZ()
        {
                #echo '9F - Used by a device to enquire which version of CEC the target supports Directly addressed'
                #echo "tx F0 9F" | cec-client -s|grep -i 'Recorder'
                                echo scan | cec-client -s -d 1|grep -v DEBUG|grep -v TRAFFIC
        }

# cec-client can tell you the commands it knows
        HELPZ()
        {
                echo 'cec-client can tell you the commands it knows'
                                echo h | cec-client -s -d 1|grep -v DEBUG|grep -v TRAFFIC
        }
# cec-client power status
        STATUZ()
        {
                echo 'pow 0' | cec-client -s -d 1 RPI
        }

# MAIN BODY OF SCRIPT
#
# Present the menu selection to the user

        echo " What would you like to do?"
        PS3="Please select a numeric option:  "

        select option in Turn_On  Turn_Off Switch_Pi_Source Mute_TV STANDBY_ALL INFO Status HELP Exit

        do
                case "$option"
                        in
                                Turn_On    )  ONZ;;
                                Turn_Off     )  OFFZ;;
                                Switch_Pi_Source )  SWITCHZ;;
                                Mute_TV )  MUTEZ;;
                                STANDBY_ALL )  STANDBYZ;;
                                INFO )  INFOZ;;
                                Status )  STATUZ;;
                                HELP )  HELPZ;;
                                Exit         )  exit 0;;
                                *            )  echo "Invalid selection ! ";;
                       esac
       done

# build own command: http://www.cec-o-matic.com/
#https://gist.github.com/ludwigm/5d51b6ae823d045ed1db
