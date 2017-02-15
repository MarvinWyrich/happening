{extends file="../layout/layout.tpl"}
{block name=title}Geschützter Bereich{/block}
{block name=id}errors/admin{/block}
{block name=description}Bereich nur für Administratoren{/block}

{block name="page-headline"}{$lang['h_admin_required']}{/block}
{block name=content}
    <p>{$lang['p_admin_required']}</p>
{/block}