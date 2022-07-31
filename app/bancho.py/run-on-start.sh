
cd /osu-server/bancho.py && git pull;

if [ "$IS_DEV" == "true" ]
then
  if ["$RUN_CODE_SERVER" == "true" ]
  then code-server --bind-addr 0.0.0.0:8080 --auth none
  else tail -f /dev/null
  fi
else python3 main.py
fi