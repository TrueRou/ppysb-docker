cd /osu-server/guweb-next && git pull;

if [ "$IS_DEV" == "true" ]
then
  echo "Running in dev mode, app is running in dev mode"
  npm run dev
else
  echo "Running in production mode. app is running in production preview mode"
  npm run preview
fi