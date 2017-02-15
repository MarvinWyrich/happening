<?php

class SessionHelper {

	/**
	 * @return bool true if user is logged in, false otherwise
	 */
	public static function is_logged_in() {
		return (isset($_SESSION['user_id']));
	}

	/**
	 * @return User currently logged in user, false otherwise
	 */
	public static function get_session_user() {
		static $user = false;
		if ($user === false) {
			$user_id = self::get_session_user_id();
			if ($user_id) {
				$user = User::get_by_id($user_id);
			}
		}
		return $user;
	}

	/**
	 * @return bool/int the id of the currently logged in user,
	 * false if not logged in
	 */
	public static function get_session_user_id() {
		if (self::is_logged_in()) {
			return $_SESSION['user_id'];
		} else {
			return false;
		}
	}

}