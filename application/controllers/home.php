<?php


class Home extends Controller {

	public function index() {
		$this->require_logout();

		$this->view('home/index');
	}

	public function login() {
		$this->require_logout();

		$errors = array();

		if (empty($_POST) === false) {
			$username = $_POST['username'];
			$password = $_POST['password'];

			$errors = LoginHelper::login($username, $password);
		}

		$data = compact('errors');
		$this->view('home/login', $data);
	}

	public function logout() {
		session_start();
		session_destroy();
		header('Location: ' . BASE_URL . 'home/index');
		exit();
	}

	public function change_language($language) {
		// set cookie then redirect, because page refresh needed
		LanguageHelper::set_language($language);
		header('Location: ' . BASE_URL . 'home/index');
		exit();
	}
}