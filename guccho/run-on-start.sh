cd /guccho && git pull

if [ "$DRY_RUN" == "true" ]; then
	echo "Running in dev mode. App is not running."
	tail -f /dev/null
else
	echo "App is running in prod mode w/ dev env files."
	pnpm start:prod
fi
