<?php
session_start();

// Composer autoloader
require_once 'vendor/autoload.php';

require_once 'core/App.php';
require_once 'core/Controller.php';
require_once 'database.php';

$app = new App;