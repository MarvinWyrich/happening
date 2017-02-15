<?php

class LoginHelper {

	/**
	 * @param $username
	 * @param $password
	 * @return array with errors if login was not successful, redirects otherwise
	 */
	public static function login($username, $password) {
		$errors = array();

		if (empty($username) || empty($password)) {
			$errors[] = $GLOBALS['lang']['error_please_insert_username_and_password'];
		} else if (self::user_exists($username) === false) {
			$errors[] = $GLOBALS['lang']['error_username_unknown'];
		} else {
			$login = self::perform_login($username, $password);

			if ($login === false) {
				$errors[] = $GLOBALS['lang']['error_wrong_login_combination'];
			} else {
				$_SESSION['user_id'] = $login;
				header('Location: ' . BASE_URL . 'summary');
				exit();
			}
		}

		return $errors;
	}

	private static function user_exists($username)	{
		$count = User::query()->where('username', $username)->count();
		return $count == 1;
	}

	private static function perform_login($username, $password) {
		$user = User::get_by_username($username);

		if (!$user) {
			return false;
		}

		if (!password_verify($password, $user->password)) {
			return false;
		}

		return $user->id;
	}

}