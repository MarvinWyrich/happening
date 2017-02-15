<?php

use Illuminate\Database\Capsule\Manager as Capsule;

$capsule = new Capsule();

$capsule->addConnection([
	'driver' => 'mysql',
	'host' => 'localhost',
	'username' => 'root',
	'password' => '',
	'database' => 'thesis',
	'charset' => 'utf8',
	'collation' => 'utf8_bin',
	'prefix' => ''
]);

$capsule->bootEloquent();
