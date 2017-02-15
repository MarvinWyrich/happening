<?php

class AvatarHelper {

	/**
	 * Returns the URL to the avatar with the given $avatar_name
	 *
	 * @param $avatar_name file name with extension
	 * @return string
	 */
	public static function get_avatar_url($avatar_name) {
		if ($avatar_name == null || empty($avatar_name)) {
			return 'htdocs/img/avatars/default.png';
		}

		return 'htdocs/img/avatars/' . $avatar_name;
	}

}
