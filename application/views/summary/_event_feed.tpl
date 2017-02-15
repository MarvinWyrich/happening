{*
requires:
    - $events (orderded by 'create_time' descending!)
    - $hide_irrelevant_events (boolean)
*}

{$current_date_year = date("Y")}
{$current_date_day_of_year = date("z")}
{$current_date_day_of_year = 367}
{$number_of_irrelevant_events = 0}
{$event_group = 0}

<ul class="ignore-timeless event-feed">
    {foreach $events as $event}
        {$is_relevant = true}
        {if $hide_irrelevant_events}
            {if $event->priority == 3} {* priority 3 is never relevant to others *}
                {$is_relevant = false}
            {elseif $event->priority == 2 && $priority_relevant_dates['last_monday']->getTimestamp() > strtotime($event->create_time)} {* priority 2 is relevant for a maximum of one week *}
                {$is_relevant = false}
            {/if}
        {/if}

        {$create_time_year = $event->create_time|date_format:"%Y"}
        {$create_time_day_of_year = $event->create_time|date_format:"%j"}

        {if $create_time_year < $current_date_year || $create_time_day_of_year < $current_date_day_of_year}
            {* before inserting a new headline, we check if there are hidden irrelevant events for the previous date
                and if so we insert a toggle button *}
            {if $number_of_irrelevant_events > 0}
                <li>
                    <button class="button secondary-button show-irrelevant-events-button" data-group="{$event_group}">
                        {$number_of_irrelevant_events} {if $number_of_irrelevant_events == 1}{$lang['folded_events_singular']}{else}{$lang['folded_events_plural']}{/if}
                    </button>
                </li>
                {$number_of_irrelevant_events = 0}
            {/if}

            <li><h3>{$event->create_time|date_format:"%d.%m.%Y"}</h3></li>
            {$current_date_year = $create_time_year}
            {$current_date_day_of_year = $create_time_day_of_year}
            {$event_group = $event_group + 1}
        {/if}

        {if !$is_relevant}
            {$number_of_irrelevant_events = $number_of_irrelevant_events + 1}
        {/if}

        <li id="event-{$event->id}" class="event priority-{$event->priority} {if !$is_relevant}irrelevant{/if} group-{$event_group}">
            <div class="event-content">
                <img class="creator-avatar" src="{AvatarHelper::get_avatar_url($event->user->avatar_name)}" alt="Avatar">
                <div class="event-info">
                    {if SessionHelper::get_session_user_id() == $event->creator_id}
                        <button title="Eintrag bearbeiten" class="button secondary-button edit-event-button" data-id="{$event->id}">{$lang['edit_button']}</button>
                    {/if}
                    <div class="event-creator"><a>{$event->user->first_name} {$event->user->last_name}</a></div>
                    {$event->text|nl2br}
                </div>
            </div>
            <ul class="error-container"></ul>
            <div class="edit-form-placeholder"></div>
        </li>
    {/foreach}

    {if $number_of_irrelevant_events > 0}
        <li>
            <button class="button secondary-button show-irrelevant-events-button" data-group="{$event_group}">
                {$number_of_irrelevant_events} {if $number_of_irrelevant_events == 1}{$lang['folded_events_singular']}{else}{$lang['folded_events_plural']}{/if}
            </button>
        </li>
        {$number_of_irrelevant_events = 0}
    {/if}
</ul>