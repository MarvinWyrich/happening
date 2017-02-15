<?php

class User extends Model {

	public $fillable = ['username', 'first_name', 'last_name', 'avatar_name', 'password'];

	public static function get_by_id($id) {
		return User::find($id);
	}

	public static function get_by_username($username) {
		return User::where('username', $username)->first();
	}
}