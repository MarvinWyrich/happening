{*
requires:
    - form_action
*}

{if !isset($form_id)}
    {$form_id = 'event-form'}
{/if}

{$event_text = ''}
{$priority = '2'}
{$create_time = $smarty.now|date_format:"%d.%m.%Y"}
{$event_id = 0}

{if isset($event)}
    {$priority = $event->priority}
    {$event_text = $event->text}
    {$create_time = $event->create_time|date_format:"%d.%m.%Y"}
    {$event_id = $event->id}
{/if}

{if isset($smarty.post.priority)}
    {$priority = $smarty.post.priority}
{/if}

{if isset($smarty.post.text)}
    {$event_text = $smarty.post.text}
{/if}

{if isset($smarty.post.create_time)}
    {$create_time = $smarty.post.create_time}
{/if}

<form action="{$form_action}" method="post" id="{$form_id}">
    <div class="row">
        <div class="col">
            <label for="event-text-{$form_id}">{$lang['label_activity_or_event']}</label>
            <textarea id="event-text-{$form_id}" name="event_text">{$event_text}</textarea>
        </div>
    </div>
    <div class="row">
        <div class="col span-3-4">
            <label for="event-priority-{$form_id}">{$lang['label_priority']}</label>
            <select name="priority" id="event-priority-{$form_id}">
                <option value="1" {if $priority == "1"}selected{/if}>{$lang['option_priority_one']}</option>
                <option value="2" {if $priority == "2"}selected{/if}>{$lang['option_priority_two']}</option>
                <option value="3" {if $priority == "3"}selected{/if}>{$lang['option_priority_three']}</option>
            </select>
        </div>
        <div class="col span-1-4">
            <label for="datepicker-create-time-{$form_id}">{$lang['label_date']}</label>
            <input type="text" id="datepicker-create-time-{$form_id}" class="datepicker-input" name="create_time" value="{$create_time}">
        </div>
    </div>
    <div class="button-row">
        {if isset($is_edit_form) && $is_edit_form == true}
            <button class="button primary-button">{$lang['save_event_button']}</button>
            <button class="button secondary-button cancel-edit-form">{$lang['cancel_button']}</button>
            <button class="f-right button secondary-button delete-event-button">{$lang['delete_button']}</button>
        {else}
            <button class="button primary-button">{$lang['add_event_button']}</button>
        {/if}
    </div>
    <input type="hidden" name="event_id" value="{$event_id}">
</form>