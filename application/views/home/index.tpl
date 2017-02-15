{extends file="../layout/layout.tpl"}
{block name=title}Home{/block}
{block name=id}home/index{/block}
{block name=description}Beschreibung des Tools{/block}

{block name="page-headline"}{$lang["h_home_index"]}{/block}
{block name=content}
	<p>{$lang["p_about_project"]}</p>

	<p class="button-row">
		<a href="home/change_language/DE" class="button secondary-button
			{if LanguageHelper::get_language() == 'DE'}selected-language{/if}">Deutsch</a>
		<a href="home/change_language/EN" class="button secondary-button
			{if LanguageHelper::get_language() == 'EN'}selected-language{/if}">English</a>
	</p>
{/block}
