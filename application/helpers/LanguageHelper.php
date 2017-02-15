<?php

class LanguageHelper {

	private static $cookie_name = 'language_cookie';
	private static $default_language = 'DE';

	/**
	 * If no language cookie is set it will be created with an initial value
	 *
	 * @param $language (optional)
	 */
	public static function create_language_cookie_if_not_exist($language = null) {
		if (!isset($_COOKIE[self::$cookie_name])) {
			if ($language == null) {
				$language = self::$default_language;
			}

			setcookie(self::$cookie_name, $language, time() + (86400 * 30), "/"); // 30 days
		}
	}

	/**
	 * @return String current value in the language cookie or default language if not set
	 */
	public static function get_language() {
		return isset($_COOKIE[self::$cookie_name]) ? $_COOKIE[self::$cookie_name] : self::$default_language;
	}

	/**
	 * Sets or updates the language cookie with the given value
	 *
	 * @param $language
	 */
	public static function set_language($language) {
		setcookie(self::$cookie_name, $language, time() + (86400 * 30), "/"); // 30 days
	}

	/**
	 * @return String default language value
	 */
	public static function get_default_language() {
		return self::$default_language;
	}

}
