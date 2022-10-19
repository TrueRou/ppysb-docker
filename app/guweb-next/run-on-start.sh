cd /osu-server/guweb-next && git pull;

if [ "$IS_DEV" == "true" ]
then
  echo "App is running in dev mode."
  npm run dev
else
  echo "App is running in production preview mode"
  npm run preview
fi