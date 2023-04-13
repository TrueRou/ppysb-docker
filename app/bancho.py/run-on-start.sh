cd /osu-server/bancho.py && git pull

if [ "$DRY_RUN" == "true" ]; then
  echo "Running in dev mode, app is not running."
  tail -f /dev/null
else
  echo "Running in production mode."
  DEVELOPER_MODE=False DEBUG=False python3 main.py
fi
