cd /osu-server/guweb && git pull

if [ "$DRY_RUN" == "true" ]; then
  echo "Running in dev mode, app is not running."
  tail -f /dev/null
else
  echo "Running in production mode."
  python3 main.py
fi
