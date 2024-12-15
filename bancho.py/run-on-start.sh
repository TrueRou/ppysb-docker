cd /osu-server/bancho.py && git pull

if [ "$PROD_MODE" == "true" ]; then
  echo "Running in production mode."
  DEVELOPER_MODE=False DEBUG=False python3 main.py
else
  echo "Running in dev mode, app is not running."
  tail -f /dev/null
fi
