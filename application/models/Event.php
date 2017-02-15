<?php

class Event extends Model {

	public $fillable = ['creator_id', 'create_time', 'text', 'priority', 'is_public'];

	public function user() {
		return $this->HasOne('User', 'id', 'creator_id');
	}

	public function scopeOrdered($query) {
		return $query
			->orderBy('create_time', 'desc')
			->orderBy('priority', 'asc')
			->orderBy('creator_id', 'asc')
			->get();
	}

}