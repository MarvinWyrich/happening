<?php

class Summary extends Controller {

	/**
	 * Shows the summary of all events of the team, filtered by the given parameters
	 */
	public function index() {
		$this->require_login();

		// initialize some variables with default values
		$hide_irrelevant_events = false;
		$priority_relevant_dates['current_date'] = DateTime::createFromFormat('d.m.Y|', date('d.m.Y'));
		$priority_relevant_dates['last_monday'] = DateTime::createFromFormat('d.m.Y|', date('d.m.Y', strtotime('Monday last week')));
		$date_from = DateTime::createFromFormat('d.m.Y|', date('d.m.Y', time() - 3 * 86400));
		$date_to = new DateTime('now');
		$date_to->setTime(23, 59, 59);

		if (isset($_GET['date_from']) && $this->is_valid_date_input($_GET['date_from'])) {
			$date_from = DateTime::createFromFormat('d.m.Y|', $_GET['date_from']);
		}

		if (isset($_GET['date_to']) && $this->is_valid_date_input($_GET['date_to'])) {
			$date_to = DateTime::createFromFormat('d.m.Y', $_GET['date_to']);
			$date_to->setTime(23, 59, 59);
		}

		if (isset($_GET['hide_irrelevant_events']) && $_GET['hide_irrelevant_events'] == 'true') {
			$hide_irrelevant_events = true;
		}

		$events = Event::with('user')
			->whereDate('create_time', '>=', $date_from)
			->whereDate('create_time', '<=', $date_to)
			->ordered();


		$date_from_value = date_format($date_from, 'd.m.Y');
		$date_to_value = date_format($date_to, 'd.m.Y');
		$data = compact('events', 'date_from_value', 'date_to_value', 'hide_irrelevant_events', 'priority_relevant_dates');

		$this->view('summary/index', $data);
	}

	/**
	 * Adds an event
	 */
	public function add() {
		$this->require_login();

		$errors = array();
		if (isset($_POST['event_text'])) {
			$errors = $this->validate_event($errors, $_POST['event_text'], $_POST['priority'], $_POST['create_time']);

			if (count($errors) == 0) {
				$event = new Event;
				$event->creator_id = SessionHelper::get_session_user_id();
				$event->create_time = DateTime::createFromFormat('d.m.Y', $_POST['create_time']);
				$event->create_time->setTime(0,0,0);
				$event->text = $_POST['event_text'];
				$event->priority = $_POST['priority'];
				$event->is_public = 1;
				$event->save();

				header('Location: ' . BASE_URL . 'summary/add?successful=true');
				exit();
			}
		}

		$user_id = SessionHelper::get_session_user_id();
		$latest_own_entries = Event::query()
			->where('creator_id', $user_id)
			->limit(10)
			->ordered();

		$successful_created = isset($_GET['successful']) ? true : false;

		$data = compact('errors', 'latest_own_entries', 'successful_created');

		$this->view('summary/add', $data);
	}

	/**
	 * Edits an event.
	 * Requires an ajax request of type POST
	 */
	public function ajax_edit() {
		$errors = array();
		$event_id = isset($_POST['event_id']) ? $_POST['event_id'] : null;

		$event = Event::query()
			->where('id', $event_id)
			->first();

		if ($event == null) {
			$errors[0] = $GLOBALS['lang']['error_event_not_found'];
			echo json_encode($errors);
			exit();
		}

		if (!$event->creator_id == SessionHelper::get_session_user_id()) {
			$errors[0] = $GLOBALS['lang']['error_not_allowed_to_edit'];
			echo json_encode($errors);
			exit();
		}

		if (isset($_POST['event_text'])) {
			$errors = $this->validate_event($errors, $_POST['event_text'], $_POST['priority'], $_POST['create_time']);

			if (count($errors) == 0) {
				$event->create_time = DateTime::createFromFormat('d.m.Y', $_POST['create_time']);;
				$event->create_time->setTime(0,0,0);
				$event->text = $_POST['event_text'];
				$event->priority = $_POST['priority'];
				$event->is_public = 1;
				$event->save();
			}
		}

		echo json_encode($errors);
		exit();
	}

	/**
	 * Deletes and event.
	 * Requires an ajax request of type POST
	 */
	public function ajax_delete() {
		$errors = array();
		$event_id = isset($_POST['event_id']) ? $_POST['event_id'] : null;

		$event = Event::query()
			->where('id', $event_id)
			->first();

		if ($event == null) {
			$errors[0] = $GLOBALS['lang']['error_event_not_found'];
			echo json_encode($errors);
			exit();
		}

		if (!$event->creator_id == SessionHelper::get_session_user_id()) {
			$errors[0] = $GLOBALS['lang']['error_not_allowed_to_delete'];
			echo json_encode($errors);
			exit();
		}

		$successful = $event->delete();

		if (!$successful) {
			$errors[0] = $GLOBALS['lang']['error_event_could_not_be_deleted'];
		}

		echo json_encode($errors);
	}

	/**
	 * Returns the rendered _event_form.tpl.
	 * Requires an ajax request with the event_id
	 */
	public function ajax_get_event_form() {
		$event_id = $_REQUEST['event_id'];
		$event = Event::query()
			->where('id', $event_id)
			->first();
		$form_action = 'summary/ajax_edit';
		$form_id = 'summary-edit-form-'.$event_id;
		$is_edit_form = true;
		$data = compact('form_action', 'form_id', 'event', 'is_edit_form');
		$this->view('summary/_event_form.tpl', $data);
	}

	/**
	 * Validates the given text, priority and create time of an event
	 * @return array errors
	 */
	private function validate_event($errors, $event_text, $priority, $create_time) {
		$priority = (int) $priority;

		if (empty(trim($event_text))) {
			$errors[] = $GLOBALS['lang']['error_please_insert_event'];
		}

		if ($priority != 1 && $priority != 2 && $priority != 3) {
			$errors[] = $GLOBALS['lang']['error_please_insert_valid_priority'];
		}

		if (!$this->is_valid_date_input($_POST['create_time'])) {
			$errors[] = $GLOBALS['lang']['error_please_insert_valid_date'];
		}

		return $errors;
	}

	/**
	 * @param $date_input
	 * @return bool
	 */
	private function is_valid_date_input($date_input) {
		$date_arr = explode('.', $date_input);
		if (count($date_arr) == 3 && checkdate($date_arr[1], $date_arr[0], $date_arr[2])) {
			return true;
		}
		return false;
	}

}