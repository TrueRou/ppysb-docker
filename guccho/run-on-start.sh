cd /osu-server/guccho && git pull

if [ "$DRY_RUN" == "true" ]; then
  echo "Running in dev mode. App is not running."
  tail -f /dev/null
else
  echo "App is running in preview mode."
  # generate prisma client
  npm_config_yes=true npx prisma generate
  npm run build
  npm run preview
fi
