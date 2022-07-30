cd /osu-server/guweb && git pull;


if [ "$IS_DEV" == "true" ];
then code-server --bind-addr 0.0.0.0:8080 --auth none;
else python3 main.py;
fi