<?php

class App {

	protected $controller = 'home';
	protected $method = 'index';
	protected $params = [];

	private $CONTROLLER_PATH = 'application/controllers/';
	private $VIEW_PATH = 'application/views/';
	private $BASE_URL = '/happening/';

	public function __construct() {
		define('BASE_URL', $this->BASE_URL);

		$url = $this->parseUrl();
		if (file_exists($this->CONTROLLER_PATH . $url[0] . '.php')) {
			$this->controller = $url[0];
			unset($url[0]);
		}

		require_once $this->CONTROLLER_PATH . $this->controller . '.php';

		$this->controller = new $this->controller;

		if (isset($url[1])) {
			if (method_exists($this->controller, $url[1])) {
				$this->method = $url[1];
				unset($url[1]);
			}
		}

		$this->params = $url ? array_values($url) : [];

		// if loading the language file is not successful, an error is shown and
		// the language will be reset to default language
		$this->load_language_file();

		call_user_func_array([$this->controller, $this->method], $this->params);
	}

	public function parseUrl() {
		if (isset($_GET['url'])) {
			return $url = explode('/', filter_var(rtrim($_GET['url'], '/'), FILTER_SANITIZE_URL));
		}
	}

	private function load_language_file() {
		LanguageHelper::create_language_cookie_if_not_exist();

		$language = LanguageHelper::get_language();
		$language_file = $this->VIEW_PATH . 'language/' . $language . '.php';
		if (file_exists($language_file)) {
			require_once($language_file);
			return true;
		} else {
			LanguageHelper::set_language(LanguageHelper::get_default_language());
			$template = $this->VIEW_PATH . 'errors/language_file_not_found.tpl';

			$smarty = new Smarty;
			$smarty->setCompileDir('../cache/smarty/templates_c');
			$smarty->display($template);
			exit();
		}
	}

}