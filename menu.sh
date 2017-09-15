#!/bin/bash
#  *****Z
#
# KODI status checks
#
# Author Nick Farrow
#
# Initial Release: 0

yourname="Nick"

# Get what's playing
        TITLEZ()
        {
                echo "Currently playing."
                curl -s --user foo:bar --header 'Content-Type: application/json' --data-binary '{    "jsonrpc": "2.0",    "method": "Player.GetItem","params": {"properties": [ "file"],"playerid":1},"id": "VideoGetItem"}' 'http://127.0.0.1:8080/jsonrpc'| python -m json.tool|grep -i file
        curl -s --user foo:bar --header 'Content-Type: application/json' --data-binary '{    "jsonrpc": "2.0",    "method": "Player.GetItem","params": {"properties": [ "file"],"playerid":1},"id": "VideoGetItem"}' 'http://127.0.0.1:8080/jsonrpc'| python -m json.tool|grep -i label
        printf "\n"
                }



# Get how much is left of film
        TIMEZ()
        {
                #Gets percentage and prints
                curl -s --user foo:bar --header 'Content-Type: application/json' --data-binary '{    "jsonrpc": "2.0",    "method": "Player.GetItem","params": {"properties": [ "file"],"playerid":1},"id": "VideoGetItem"}' 'http://127.0.0.1:8080/jsonrpc'| python -m json.tool|grep -i file
        wget -q -O- --header='Content-Type: application/json' --post-data='{"jsonrpc": "2.0", "method": "Player.GetProperties", "params": { "playerid": 1, "properties": ["percentage"] }, "id": 1}' 'http://127.0.0.1:8080/jsonrpc'| python -m json.tool|grep -i percentage

                #Gets total hour and saves to file
                wget -q -O- --header='Content-Type: application/json' --post-data='{"jsonrpc": "2.0", "method": "Player.GetProperties", "params": { "playerid": 1, "properties": ["totaltime"] }, "id": 1}' 'http://127.0.0.1:8080/jsonrpc'| python -m json.tool|grep -i hour|awk '{print $2}'|rev|cut -c 2-|rev>totalhour
                #Gets total minutes and saves to file
                wget -q -O- --header='Content-Type: application/json' --post-data='{"jsonrpc": "2.0", "method": "Player.GetProperties", "params": { "playerid": 1, "properties": ["totaltime"] }, "id": 1}' 'http://127.0.0.1:8080/jsonrpc'| python -m json.tool|grep -i minutes|awk '{print $2}'|rev|cut -c 2-|rev>totalminutes
                Totalhourz=$(cat totalhour)
                Totalminutez=$(cat totalminutes)

                #Gets hours left and saves to file
                wget -q -O- --header='Content-Type: application/json' --post-data='{"jsonrpc": "2.0", "method": "Player.GetProperties", "params": { "playerid": 1, "properties": ["time"] }, "id": 1}' 'http://127.0.0.1:8080/jsonrpc'| python -m json.tool|grep -i hour|awk '{print $2}'|rev|cut -c 2-|rev>hour
                #Gets minutes left and saves to file
                wget -q -O- --header='Content-Type: application/json' --post-data='{"jsonrpc": "2.0", "method": "Player.GetProperties", "params": { "playerid": 1, "properties": ["time"] }, "id": 1}' 'http://127.0.0.1:8080/jsonrpc'| python -m json.tool|grep -i minutes|awk '{print $2}'|rev|cut -c 2-|rev>minutes


                hourz=$(cat hour)
                minutez=$(cat minutes)


                echo -n "Hours:"
                expr $Totalhourz - $hourz
                echo -n "Minutes:"
                expr $Totalminutez - $minutez

                rm -rf totalhour
                rm -rf totalminutes
                rm -rf hour
                rm -rf minutes

                }

# Check if movie was played
        CHECK_PLAYZ()
        {
        tail -n 50 $HOME/.kodi/temp/kodi.log|grep DVDPlayer
                printf "\n"
        }

# Check for errors when movie was started
        CHECK_ERRORZ()
        {
        tail -n 10000 $HOME/.kodi/temp/kodi.log|grep DVDPlayer|grep -i error
                printf "\n"
        }

# Check last played movies
        LAST_PLAYEDZ()
        {
        tail -n 10000 $HOME/.kodi/temp/kodi.log|grep -i Opening|grep -v source
        #tail -n 10000 $HOME/.kodi/temp/kodi.log|grep DVDPlayer|grep -i Opening
                printf "\n"
        }

# Send messages to the screen
        MESSAGEZ()
        {
        echo "Please enter your Message:"
                read messageqqq
                curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"GUI.ShowNotification","params":{"title":"FROM '$yourname'","message":"'$messageqqq'"},"id":1}' http://127.0.0.1:8080/jsonrpc
                printf "\n"
        }

# Clean Data
        CLEANZ()
        {

        curl --data-binary '{ "jsonrpc": "2.0", "method": "VideoLibrary.Clean", "id": "mybash"}' -H 'content-type: application/json;' http://127.0.0.1:8080/jsonrpc
        printf "\n"
        }
# Clean Data
        CLEANZ()
        {

        curl --data-binary '{ "jsonrpc": "2.0", "method": "VideoLibrary.Clean", "id": "mybash"}' -H 'content-type: application/json;' http://127.0.0.1:8080/jsonrpc
        printf "\n"
        }
# Update Data
        UPDATEZ()
        {

        curl --data-binary '{ "jsonrpc": "2.0", "method": "VideoLibrary.Scan", "id": "mybash"}' -H 'content-type: application/json;' http://127.0.0.1:8080/jsonrpc
        printf "\n"
        }

# MAIN BODY OF SCRIPT
#
# Present the menu selection to the user

        echo " What would you like to do?"
        PS3="Please select a numeric option:  "

        select option in TITLE  TIME_LEFT Check_if_played Check_for_errors Last_played_Movies MESSAGE CLEAN UPDATE Exit

        do
                case "$option"
                        in
                                TITLE    )  TITLEZ;;
                                TIME_LEFT     )  TIMEZ;;
                                Check_if_played )  CHECK_PLAYZ;;
                                Check_for_errors )  CHECK_ERRORZ;;
                                Last_played_Movies )  LAST_PLAYEDZ;;
                                MESSAGE     )  MESSAGEZ;;
                                CLEAN     )  CLEANZ;;
                                UPDATE     )  UPDATEZ;;
                                Exit         )  exit 0;;
                                *            )  echo "Invalid selection ! ";;
                       esac
       done

