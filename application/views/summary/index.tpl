{extends file="../layout/layout.tpl"}
{block name=title}Übersicht{/block}
{block name=id}summary/index{/block}
{block name=description}Zusammenfassende Darstellung der Ereignisse aller Teammitglieder{/block}

{block name="page-headline-wrap"}{/block}
{block name=content}
    <form method="get" action="summary" id="filter-form">
        <div class="row">
            <div class="col span-1-2">
                <label for="datepicker-from">{$lang['label_datepicker_from']}</label>
                <input type="text" id="datepicker-from" class="datepicker-input" name="date_from" value="{$date_from_value}">
            </div>
            <div class="col span-1-2">
                <label for="datepicker-to">{$lang['label_datepicker_to']}</label>
                <input type="text" id="datepicker-to" class="datepicker-input" name="date_to" value="{$date_to_value}">
            </div>
        </div>
        <div class="row">
            <div class="col span-1-2">
                <label for="hide-irrelevant-events">
                    <input type="checkbox" id="hide-irrelevant-events" name="hide_irrelevant_events" value="true" {if $hide_irrelevant_events}checked{/if}><span class="checkbox-label">{$lang['label_hide_irrelevant_events']}</span>
                </label>
            </div>
            <div class="col span-1-2">
                <div class="f-right">
                    <input type="submit" value="{$lang['update_filter_button']}" class="button primary-button">
                </div>
            </div>
        </div>
    </form>

    {if $events->count() > 0}
        {include file='../summary/_event_feed.tpl' events=$events hide_irrelevant_events=$hide_irrelevant_events}
    {/if}

    {if $events->count() == 0}
        <p>{$lang['p_no_matching_events_found']}</p>
    {/if}
{/block}
