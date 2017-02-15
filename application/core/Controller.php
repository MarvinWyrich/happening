<?php

class Controller {

	private $VIEW_PATH = 'application/views/';
	private $MODEL_PATH = 'application/models/';

	/**
	 * Creates and returns a new instance of type $model
	 *
	 * @param $model - name of the model class
	 * @return instance of type $model
	 */
	public function model($model) {
		require_once $this->MODEL_PATH . $model . '.php';
		return new $model();
	}

	/**
	 * Renders a smarty $template with the given $data
	 *
	 * @param $template - name of the template
	 * @param $data - optional array
	 */
	public function view($template, $data = []) {
		if (!StringHelper::ends_with($template, '.tpl')) {
			$template .= '.tpl';
		}

		$template = $this->VIEW_PATH . $template;
		$data['lang'] = $GLOBALS['lang'];

		$smarty = new Smarty;
		$smarty->setCompileDir('../cache/smarty/templates_c');
		$smarty->display($template, $data);
	}

	public function require_logout() {
		if (SessionHelper::is_logged_in()) {
			header('Location: ' . BASE_URL . 'summary');
			exit();
		}
	}

	public function require_login() {
		if (!SessionHelper::is_logged_in()) {
			header('Location: ' . BASE_URL . 'home/login');
			exit();
		}
	}

	public function require_admin() {
		$this->require_login();

		$user = SessionHelper::get_session_user();
		if (!$user->is_admin) {
			$this->view('errors/require_admin');
			exit();
		}
	}

}