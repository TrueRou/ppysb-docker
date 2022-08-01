cd /osu-server/bancho.py && git pull;

if [ "$IS_DEV" == "true" ]
then
  tail -f /dev/null
else python3 main.py
fi