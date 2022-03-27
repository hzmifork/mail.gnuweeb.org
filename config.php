<?php

date_default_timezone_set("UTC");

const BASE_PATH = __DIR__;
const STORAGE_PATH = BASE_PATH."/storage";
const PUBLIC_PATH = BASE_PATH."/public";
const STATIC_CACHE = false;

define("DB_HOST", getenv("MYSQL_HOST"));
define("DB_PORT", getenv("MYSQL_PORT"));
define("DB_NAME", getenv("MYSQL_DATABASE"));
define("DB_USER", getenv("MYSQL_USER"));
define("DB_PASS", getenv("MYSQL_PASSWORD"));
define("APP_KEY", getenv("APP_KEY"));

const USE_POSTFIX = false;
const PF_DB_HOST = DB_HOST;
const PF_DB_PORT = DB_PORT;
const PF_DB_NAME = "postfixadmin";
const PF_DB_USER = DB_USER;
const PF_DB_PASS = DB_PASS;

const PDO_PARAM = [
	"mysql:host=".DB_HOST.";port=".DB_PORT.";dbname=".DB_NAME,
	DB_USER,
	DB_PASS,
	[
		\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION
	]
];

const PF_PDO_PARAM = [
	"mysql:host=".PF_DB_HOST.";port=".PF_DB_PORT.";dbname=".PF_DB_NAME,
	PF_DB_USER,
	PF_DB_PASS,
	[
		\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION
	]
];
