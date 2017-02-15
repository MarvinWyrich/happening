<?php

class StringHelper {

	/**
	 * @param $str
	 * @param $end
	 * @return true if $str ends with $end, false otherwise
	 */
	public static function ends_with($str, $end) {
		return substr($str, -strlen($end)) == $end;
	}

}