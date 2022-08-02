cd /osu-server/bancho.py && git pull;

if [ "$IS_DEV" == "true" ]
then
  echo "Running in dev mode, app is not running."
  tail -f /dev/null
else
  echo "Running in production mode, app is running."
  python3 main.py
fi