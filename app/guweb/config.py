# -*- coding: utf-8 -*-
import os

# app name
app_name = 'guweb'

# secret key
secret_key = 'changeme'

#hCaptcha settings:
hCaptcha_sitekey = 'changeme'
hCaptcha_secret = 'changeme'

# domain (used for api, avatar, etc)
domain = 'dev.ppy.sb'

# mysql credentials
mysql = {
    'db': 'banchopy',
    'host': 'mysql',
    'user': 'root',
    'password': '',
}

# path to gulag root (must have leading and following slash)
path_to_gulag = '/osu-server/bancho.py/'

# enable debug (disable when in production to improve performance)
debug = (os.getenv('IS_DEV') or os.getenv("DRY_RUN_CONTAINER_GUWEB")) == "true"
default_locale = 'zh_CN'
create_api_key_if_not_exist = True

# disallowed names (hardcoded banned usernames)
disallowed_names = {
    'cookiezi', 'rrtyui',
    'hvick225', 'qsc20010'
}

# disallowed passwords (hardcoded banned passwords)
disallowed_passwords = {
    'password', 'minilamp'
}

# enable registration
registration = os.environ["IS_REGISTRATION_ALLOWED"] != "false"

# social links (used throughout guweb)
github = 'https://github.com/varkaria/guweb'
discord_server = 'https://discord.com/invite/Y5uPvcNpD9'
youtube = 'https://youtube.com/'
twitter = 'https://twitter.com/'
instagram = 'https://instagram.com/'
