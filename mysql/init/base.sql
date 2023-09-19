create table achievements
(
	id int auto_increment
		primary key,
	file varchar(128) not null,
	name varchar(128) charset utf8 not null,
	`desc` varchar(256) charset utf8 not null,
	cond varchar(64) not null,
	constraint achievements_desc_uindex
		unique (`desc`),
	constraint achievements_file_uindex
		unique (file),
	constraint achievements_name_uindex
		unique (name)
);

create table channels
(
	id int auto_increment
		primary key,
	name varchar(32) not null,
	topic varchar(256) not null,
	read_priv int default 1 not null,
	write_priv int default 2 not null,
	auto_join tinyint(1) default 0 not null,
	constraint channels_name_uindex
		unique (name)
);

create table clans
(
	id int auto_increment
		primary key,
	name varchar(16) charset utf8 not null,
	tag varchar(6) charset utf8 not null,
	owner int not null,
	created_at datetime not null,
	constraint clans_name_uindex
		unique (name),
	constraint clans_owner_uindex
		unique (owner),
	constraint clans_tag_uindex
		unique (tag)
);

create table client_hashes
(
	userid int not null,
	osupath char(32) not null,
	adapters char(32) not null,
	uninstall_id char(32) not null,
	disk_serial char(32) not null,
	latest_time datetime not null,
	occurrences int default 0 not null,
	primary key (userid, osupath, adapters, uninstall_id, disk_serial)
);

create table comments
(
	id int auto_increment
		primary key,
	target_id int not null comment 'replay, map, or set id',
	target_type enum('replay', 'map', 'song') not null,
	userid int not null,
	time int not null,
	comment varchar(80) charset utf8 not null,
	colour char(6) null comment 'rgb hex string'
);

create table favourites
(
	userid int not null,
	setid int not null,
	created_at int default 0 not null,
	primary key (userid, setid)
);

create table ingame_logins
(
	id int auto_increment
		primary key,
	userid int not null,
	ip varchar(45) not null comment 'maxlen for ipv6',
	osu_ver date not null,
	osu_stream varchar(11) not null,
	datetime datetime not null
);

create table relationships
(
	user1 int not null,
	user2 int not null,
	type enum('friend', 'block') not null,
	primary key (user1, user2)
);

create table logs
(
	id int auto_increment
		primary key,
	`from` int not null comment 'both from and to are playerids',
	`to` int not null,
	`action` varchar(32) not null,
	msg varchar(2048) charset utf8 null,
	time datetime not null on update CURRENT_TIMESTAMP
);

create table mail
(
	id int auto_increment
		primary key,
	from_id int not null,
	to_id int not null,
	msg varchar(2048) charset utf8 not null,
	time int null,
	`read` tinyint(1) default 0 not null
);

create table maps
(
	server enum('osu!', 'private') default 'osu!' not null,
	id int not null,
	set_id int not null,
	status int not null,
	md5 char(32) not null,
	artist varchar(128) charset utf8 not null,
	title varchar(128) charset utf8 not null,
	version varchar(128) charset utf8 not null,
	creator varchar(19) charset utf8 not null,
	filename varchar(256) charset utf8 not null,
	last_update datetime not null,
	total_length int not null,
	max_combo int not null,
	frozen tinyint(1) default 0 not null,
	plays int default 0 not null,
	passes int default 0 not null,
	mode tinyint(1) default 0 not null,
	bpm float(12,2) default 0.00 not null,
	cs float(4,2) default 0.00 not null,
	ar float(4,2) default 0.00 not null,
	od float(4,2) default 0.00 not null,
	hp float(4,2) default 0.00 not null,
	diff float(6,3) default 0.000 not null,
	primary key (server, id),
	constraint maps_id_uindex
		unique (id),
	constraint maps_md5_uindex
		unique (md5)
);

create table mapsets
(
	server enum('osu!', 'private') default 'osu!' not null,
	id int not null,
	last_osuapi_check datetime default CURRENT_TIMESTAMP not null,
	primary key (server, id),
	constraint nmapsets_id_uindex
		unique (id)
);

create table map_requests
(
	id int auto_increment
		primary key,
	map_id int not null,
	player_id int not null,
	datetime datetime not null,
	active tinyint(1) not null
);

create table performance_reports
(
	scoreid bigint(20) unsigned not null,
	mod_mode enum('vanilla', 'relax', 'autopilot') default 'vanilla' not null,
	os varchar(64) not null,
	fullscreen tinyint(1) not null,
	fps_cap varchar(16) not null,
	compatibility tinyint(1) not null,
	version varchar(16) not null,
	start_time int not null,
	end_time int not null,
	frame_count int not null,
	spike_frames int not null,
	aim_rate int not null,
	completion tinyint(1) not null,
	identifier varchar(128) null comment 'really don''t know much about this yet',
	average_frametime int not null,
	primary key (scoreid, mod_mode)
);

create table ratings
(
	userid int not null,
	map_md5 char(32) not null,
	rating tinyint(2) not null,
	primary key (userid, map_md5)
);

create table scores
(
	id bigint unsigned auto_increment
		primary key,
	map_md5 char(32) not null,
	score int not null,
	pp float(7,3) not null,
	acc float(6,3) not null,
	max_combo int not null,
	mods int not null,
	n300 int not null,
	n100 int not null,
	n50 int not null,
	nmiss int not null,
	ngeki int not null,
	nkatu int not null,
	grade varchar(2) default 'N' not null,
	status tinyint not null,
	mode tinyint not null,
	play_time datetime not null,
	time_elapsed int not null,
	client_flags int not null,
	userid int not null,
	perfect tinyint(1) not null,
	online_checksum char(32) not null
);

create table startups
(
	id int auto_increment
		primary key,
	ver_major tinyint not null,
	ver_minor tinyint not null,
	ver_micro tinyint not null,
	datetime datetime not null
);

create table stats
(
	id int auto_increment,
	mode tinyint(1) not null,
	tscore bigint unsigned default 0 not null,
	rscore bigint unsigned default 0 not null,
	pp int unsigned default 0 not null,
	plays int unsigned default 0 not null,
	playtime int unsigned default 0 not null,
	acc float(6,3) default 0.000 not null,
	max_combo int unsigned default 0 not null,
	total_hits int unsigned default 0 not null,
	replay_views int unsigned default 0 not null,
	xh_count int unsigned default 0 not null,
	x_count int unsigned default 0 not null,
	sh_count int unsigned default 0 not null,
	s_count int unsigned default 0 not null,
	a_count int unsigned default 0 not null,
	primary key (id, mode)
);

create table tourney_pool_maps
(
	map_id int not null,
	pool_id int not null,
	mods int not null,
	slot tinyint not null,
	primary key (map_id, pool_id)
);

create index tourney_pool_maps_tourney_pools_id_fk
	on tourney_pool_maps (pool_id);

create table tourney_pools
(
	id int auto_increment
		primary key,
	name varchar(16) not null,
	created_at datetime not null,
	created_by int not null
);

create index tourney_pools_users_id_fk
	on tourney_pools (created_by);

create table user_achievements
(
	userid int not null,
	achid int not null,
	primary key (userid, achid)
);

create table users
(
	id int auto_increment
		primary key,
	name varchar(32) charset utf8 not null,
	safe_name varchar(32) charset utf8 not null,
	email varchar(254) not null,
	priv int default 1 not null,
	pw_bcrypt char(60) not null,
	country char(2) default 'xx' not null,
	silence_end int default 0 not null,
	donor_end int default 0 not null,
	creation_time int default 0 not null,
	latest_activity int default 0 not null,
	clan_id int default 0 not null,
	clan_priv tinyint(1) default 0 not null,
	preferred_mode int default 0 not null,
	play_style int default 0 not null,
	custom_badge_name varchar(16) charset utf8 null,
	custom_badge_icon varchar(64) null,
	userpage_content varchar(2048) charset utf8 null,
	api_key char(36) null,
	constraint users_api_key_uindex
		unique (api_key),
	constraint users_email_uindex
		unique (email),
	constraint users_name_uindex
		unique (name),
	constraint users_safe_name_uindex
		unique (safe_name)
);

insert into users (id, name, safe_name, priv, country, silence_end, email, pw_bcrypt, creation_time, latest_activity)
values (1, 'BanchoBot', 'banchobot', 1, 'ca', 0, 'bot@akatsuki.pw',
        '_______________________my_cool_bcrypt_______________________', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

INSERT INTO stats (id, mode) VALUES (1, 0); # vn!std
INSERT INTO stats (id, mode) VALUES (1, 1); # vn!taiko
INSERT INTO stats (id, mode) VALUES (1, 2); # vn!catch
INSERT INTO stats (id, mode) VALUES (1, 3); # vn!mania
INSERT INTO stats (id, mode) VALUES (1, 4); # rx!std
INSERT INTO stats (id, mode) VALUES (1, 5); # rx!taiko
INSERT INTO stats (id, mode) VALUES (1, 6); # rx!catch
INSERT INTO stats (id, mode) VALUES (1, 8); # ap!std


# userid 2 is reserved for ppy in osu!, and the
# client will not allow users to pm this id.
# If you want this, simply remove these two lines.
alter table users auto_increment = 3;
alter table stats auto_increment = 3;

insert into channels (name, topic, read_priv, write_priv, auto_join)
values ('#osu', 'General discussion.', 1, 2, true),
	   ('#announce', 'Exemplary performance and public announcements.', 1, 24576, true),
	   ('#lobby', 'Multiplayer lobby discussion room.', 1, 2, false),
	   ('#supporter', 'General discussion for supporters.', 48, 48, false),
	   ('#staff', 'General discussion for staff members.', 28672, 28672, true),
	   ('#admin', 'General discussion for administrators.', 24576, 24576, true),
	   ('#dev', 'General discussion for developers.', 16384, 16384, true);

insert into achievements (id, file, name, `desc`, cond) values (1, 'osu-skill-pass-1', 'Rising Star', 'Can''t go forward without the first steps.', '(score.mods & 1 == 0) and 1 <= score.sr < 2 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (2, 'osu-skill-pass-2', 'Constellation Prize', 'Definitely not a consolation prize. Now things start getting hard!', '(score.mods & 1 == 0) and 2 <= score.sr < 3 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (3, 'osu-skill-pass-3', 'Building Confidence', 'Oh, you''ve SO got this.', '(score.mods & 1 == 0) and 3 <= score.sr < 4 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (4, 'osu-skill-pass-4', 'Insanity Approaches', 'You''re not twitching, you''re just ready.', '(score.mods & 1 == 0) and 4 <= score.sr < 5 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (5, 'osu-skill-pass-5', 'These Clarion Skies', 'Everything seems so clear now.', '(score.mods & 1 == 0) and 5 <= score.sr < 6 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (6, 'osu-skill-pass-6', 'Above and Beyond', 'A cut above the rest.', '(score.mods & 1 == 0) and 6 <= score.sr < 7 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (7, 'osu-skill-pass-7', 'Supremacy', 'All marvel before your prowess.', '(score.mods & 1 == 0) and 7 <= score.sr < 8 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (8, 'osu-skill-pass-8', 'Absolution', 'My god, you''re full of stars!', '(score.mods & 1 == 0) and 8 <= score.sr < 9 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (9, 'osu-skill-pass-9', 'Event Horizon', 'No force dares to pull you under.', '(score.mods & 1 == 0) and 9 <= score.sr < 10 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (10, 'osu-skill-pass-10', 'Phantasm', 'Fevered is your passion, extraordinary is your skill.', '(score.mods & 1 == 0) and 10 <= score.sr < 11 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (11, 'osu-skill-fc-1', 'Totality', 'All the notes. Every single one.', 'score.perfect and 1 <= score.sr < 2 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (12, 'osu-skill-fc-2', 'Business As Usual', 'Two to go, please.', 'score.perfect and 2 <= score.sr < 3 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (13, 'osu-skill-fc-3', 'Building Steam', 'Hey, this isn''t so bad.', 'score.perfect and 3 <= score.sr < 4 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (14, 'osu-skill-fc-4', 'Moving Forward', 'Bet you feel good about that.', 'score.perfect and 4 <= score.sr < 5 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (15, 'osu-skill-fc-5', 'Paradigm Shift', 'Surprisingly difficult.', 'score.perfect and 5 <= score.sr < 6 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (16, 'osu-skill-fc-6', 'Anguish Quelled', 'Don''t choke.', 'score.perfect and 6 <= score.sr < 7 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (17, 'osu-skill-fc-7', 'Never Give Up', 'Excellence is its own reward.', 'score.perfect and 7 <= score.sr < 8 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (18, 'osu-skill-fc-8', 'Aberration', 'They said it couldn''t be done. They were wrong.', 'score.perfect and 8 <= score.sr < 9 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (19, 'osu-skill-fc-9', 'Chosen', 'Reign among the Prometheans, where you belong.', 'score.perfect and 9 <= score.sr < 10 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (20, 'osu-skill-fc-10', 'Unfathomable', 'You have no equal.', 'score.perfect and 10 <= score.sr < 11 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (21, 'osu-combo-500', '500 Combo', '500 big ones! You''re moving up in the world!', '500 <= score.max_combo < 750 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (22, 'osu-combo-750', '750 Combo', '750 notes back to back? Woah.', '750 <= score.max_combo < 1000 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (23, 'osu-combo-1000', '1000 Combo', 'A thousand reasons why you rock at this game.', '1000 <= score.max_combo < 2000 and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (24, 'osu-combo-2000', '2000 Combo', 'Nothing can stop you now.', '2000 <= score.max_combo and mode_vn == 0');
insert into achievements (id, file, name, `desc`, cond) values (25, 'taiko-skill-pass-1', 'My First Don', 'Marching to the beat of your own drum. Literally.', '(score.mods & 1 == 0) and 1 <= score.sr < 2 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (26, 'taiko-skill-pass-2', 'Katsu Katsu Katsu', 'Hora! Izuko!', '(score.mods & 1 == 0) and 2 <= score.sr < 3 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (27, 'taiko-skill-pass-3', 'Not Even Trying', 'Muzukashii? Not even.', '(score.mods & 1 == 0) and 3 <= score.sr < 4 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (28, 'taiko-skill-pass-4', 'Face Your Demons', 'The first trials are now behind you, but are you a match for the Oni?', '(score.mods & 1 == 0) and 4 <= score.sr < 5 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (29, 'taiko-skill-pass-5', 'The Demon Within', 'No rest for the wicked.', '(score.mods & 1 == 0) and 5 <= score.sr < 6 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (30, 'taiko-skill-pass-6', 'Drumbreaker', 'Too strong.', '(score.mods & 1 == 0) and 6 <= score.sr < 7 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (31, 'taiko-skill-pass-7', 'The Godfather', 'You are the Don of Dons.', '(score.mods & 1 == 0) and 7 <= score.sr < 8 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (32, 'taiko-skill-pass-8', 'Rhythm Incarnate', 'Feel the beat. Become the beat.', '(score.mods & 1 == 0) and 8 <= score.sr < 9 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (33, 'taiko-skill-fc-1', 'Keeping Time', 'Don, then katsu. Don, then katsu..', 'score.perfect and 1 <= score.sr < 2 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (34, 'taiko-skill-fc-2', 'To Your Own Beat', 'Straight and steady.', 'score.perfect and 2 <= score.sr < 3 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (35, 'taiko-skill-fc-3', 'Big Drums', 'Bigger scores to match.', 'score.perfect and 3 <= score.sr < 4 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (36, 'taiko-skill-fc-4', 'Adversity Overcome', 'Difficult? Not for you.', 'score.perfect and 4 <= score.sr < 5 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (37, 'taiko-skill-fc-5', 'Demonslayer', 'An Oni felled forevermore.', 'score.perfect and 5 <= score.sr < 6 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (38, 'taiko-skill-fc-6', 'Rhythm''s Call', 'Heralding true skill.', 'score.perfect and 6 <= score.sr < 7 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (39, 'taiko-skill-fc-7', 'Time Everlasting', 'Not a single beat escapes you.', 'score.perfect and 7 <= score.sr < 8 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (40, 'taiko-skill-fc-8', 'The Drummer''s Throne', 'Percussive brilliance befitting royalty alone.', 'score.perfect and 8 <= score.sr < 9 and mode_vn == 1');
insert into achievements (id, file, name, `desc`, cond) values (41, 'fruits-skill-pass-1', 'A Slice Of Life', 'Hey, this fruit catching business isn''t bad.', '(score.mods & 1 == 0) and 1 <= score.sr < 2 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (42, 'fruits-skill-pass-2', 'Dashing Ever Forward', 'Fast is how you do it.', '(score.mods & 1 == 0) and 2 <= score.sr < 3 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (43, 'fruits-skill-pass-3', 'Zesty Disposition', 'No scurvy for you, not with that much fruit.', '(score.mods & 1 == 0) and 3 <= score.sr < 4 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (44, 'fruits-skill-pass-4', 'Hyperdash ON!', 'Time and distance is no obstacle to you.', '(score.mods & 1 == 0) and 4 <= score.sr < 5 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (45, 'fruits-skill-pass-5', 'It''s Raining Fruit', 'And you can catch them all.', '(score.mods & 1 == 0) and 5 <= score.sr < 6 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (46, 'fruits-skill-pass-6', 'Fruit Ninja', 'Legendary techniques.', '(score.mods & 1 == 0) and 6 <= score.sr < 7 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (47, 'fruits-skill-pass-7', 'Dreamcatcher', 'No fruit, only dreams now.', '(score.mods & 1 == 0) and 7 <= score.sr < 8 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (48, 'fruits-skill-pass-8', 'Lord of the Catch', 'Your kingdom kneels before you.', '(score.mods & 1 == 0) and 8 <= score.sr < 9 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (49, 'fruits-skill-fc-1', 'Sweet And Sour', 'Apples and oranges, literally.', 'score.perfect and 1 <= score.sr < 2 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (50, 'fruits-skill-fc-2', 'Reaching The Core', 'The seeds of future success.', 'score.perfect and 2 <= score.sr < 3 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (51, 'fruits-skill-fc-3', 'Clean Platter', 'Clean only of failure. It is completely full, otherwise.', 'score.perfect and 3 <= score.sr < 4 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (52, 'fruits-skill-fc-4', 'Between The Rain', 'No umbrella needed.', 'score.perfect and 4 <= score.sr < 5 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (53, 'fruits-skill-fc-5', 'Addicted', 'That was an overdose?', 'score.perfect and 5 <= score.sr < 6 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (54, 'fruits-skill-fc-6', 'Quickening', 'A dash above normal limits.', 'score.perfect and 6 <= score.sr < 7 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (55, 'fruits-skill-fc-7', 'Supersonic', 'Faster than is reasonably necessary.', 'score.perfect and 7 <= score.sr < 8 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (56, 'fruits-skill-fc-8', 'Dashing Scarlet', 'Speed beyond mortal reckoning.', 'score.perfect and 8 <= score.sr < 9 and mode_vn == 2');
insert into achievements (id, file, name, `desc`, cond) values (57, 'mania-skill-pass-1', 'First Steps', 'It isn''t 9-to-5, but 1-to-9. Keys, that is.', '(score.mods & 1 == 0) and 1 <= score.sr < 2 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (58, 'mania-skill-pass-2', 'No Normal Player', 'Not anymore, at least.', '(score.mods & 1 == 0) and 2 <= score.sr < 3 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (59, 'mania-skill-pass-3', 'Impulse Drive', 'Not quite hyperspeed, but getting close.', '(score.mods & 1 == 0) and 3 <= score.sr < 4 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (60, 'mania-skill-pass-4', 'Hyperspeed', 'Woah.', '(score.mods & 1 == 0) and 4 <= score.sr < 5 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (61, 'mania-skill-pass-5', 'Ever Onwards', 'Another challenge is just around the corner.', '(score.mods & 1 == 0) and 5 <= score.sr < 6 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (62, 'mania-skill-pass-6', 'Another Surpassed', 'Is there no limit to your skills?', '(score.mods & 1 == 0) and 6 <= score.sr < 7 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (63, 'mania-skill-pass-7', 'Extra Credit', 'See me after class.', '(score.mods & 1 == 0) and 7 <= score.sr < 8 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (64, 'mania-skill-pass-8', 'Maniac', 'There''s just no stopping you.', '(score.mods & 1 == 0) and 8 <= score.sr < 9 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (65, 'mania-skill-fc-1', 'Keystruck', 'The beginning of a new story', 'score.perfect and 1 <= score.sr < 2 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (66, 'mania-skill-fc-2', 'Keying In', 'Finding your groove.', 'score.perfect and 2 <= score.sr < 3 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (67, 'mania-skill-fc-3', 'Hyperflow', 'You can *feel* the rhythm.', 'score.perfect and 3 <= score.sr < 4 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (68, 'mania-skill-fc-4', 'Breakthrough', 'Many skills mastered, rolled into one.', 'score.perfect and 4 <= score.sr < 5 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (69, 'mania-skill-fc-5', 'Everything Extra', 'Giving your all is giving everything you have.', 'score.perfect and 5 <= score.sr < 6 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (70, 'mania-skill-fc-6', 'Level Breaker', 'Finesse beyond reason', 'score.perfect and 6 <= score.sr < 7 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (71, 'mania-skill-fc-7', 'Step Up', 'A precipice rarely seen.', 'score.perfect and 7 <= score.sr < 8 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (72, 'mania-skill-fc-8', 'Behind The Veil', 'Supernatural!', 'score.perfect and 8 <= score.sr < 9 and mode_vn == 3');
insert into achievements (id, file, name, `desc`, cond) values (73, 'all-intro-suddendeath', 'Finality', 'High stakes, no regrets.', 'score.mods == 32');
insert into achievements (id, file, name, `desc`, cond) values (74, 'all-intro-hidden', 'Blindsight', 'I can see just perfectly', 'score.mods & 8');
insert into achievements (id, file, name, `desc`, cond) values (75, 'all-intro-perfect', 'Perfectionist', 'Accept nothing but the best.', 'score.mods & 16384');
insert into achievements (id, file, name, `desc`, cond) values (76, 'all-intro-hardrock', 'Rock Around The Clock', "You can\'t stop the rock.", 'score.mods & 16');
insert into achievements (id, file, name, `desc`, cond) values (77, 'all-intro-doubletime', 'Time And A Half', "Having a right ol\' time. One and a half of them, almost.", 'score.mods & 64');
insert into achievements (id, file, name, `desc`, cond) values (78, 'all-intro-flashlight', 'Are You Afraid Of The Dark?', "Harder than it looks, probably because it\'s hard to look.", 'score.mods & 1024');
insert into achievements (id, file, name, `desc`, cond) values (79, 'all-intro-easy', 'Dial It Right Back', 'Sometimes you just want to take it easy.', 'score.mods & 2');
insert into achievements (id, file, name, `desc`, cond) values (80, 'all-intro-nofail', 'Risk Averse', 'Safety nets are fun!', 'score.mods & 1');
insert into achievements (id, file, name, `desc`, cond) values (81, 'all-intro-nightcore', 'Sweet Rave Party', 'Founded in the fine tradition of changing things that were just fine as they were.', 'score.mods & 512');
insert into achievements (id, file, name, `desc`, cond) values (82, 'all-intro-halftime', 'Slowboat', 'You got there. Eventually.', 'score.mods & 256');
insert into achievements (id, file, name, `desc`, cond) values (83, 'all-intro-spunout', 'Burned Out', 'One cannot always spin to win.', 'score.mods & 4096');
