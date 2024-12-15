cd /osu-server/Guccho && git pull

if [ "$PROD_MODE" == "true" ] || [ "$PROD_MODE" == "True" ]; then
  echo "Running in production mode."
  pnpm build && pnpm start:prod
  tail -f /dev/null
else
  echo "Running in dev mode, app is not running."
  tail -f /dev/null
fi
