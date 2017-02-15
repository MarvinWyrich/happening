{extends file="../layout/layout.tpl"}
{block name=title}{$lang['h_add_event']}{/block}
{block name=id}summary/add{/block}
{block name=description}Individuelles Erfassen einer Aktivität oder eines Ereignisses{/block}

{block name="page-headline"}{$lang['h_add_event']}{/block}
{block name=content}
    {if $successful_created}
        <div><strong>{$lang['p_add_successful']}</strong></div>
    {/if}

    {include file="../summary/_event_form.tpl" form_action="summary/add"}

    {if ($latest_own_entries->count() > 0)}
        <hr>
        <h3>{$lang['h_your_newest_events']}</h3>
        {include file="../summary/_event_feed.tpl" events=$latest_own_entries hide_irrelevant_events=false}
    {/if}
{/block}
