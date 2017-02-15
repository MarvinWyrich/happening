<!DOCTYPE html>
<html lang="de">
<head>
	<meta charset="utf-8">
	<title>{block name="title"}{/block} - happening</title>
	<meta name="description" content="{block name="description"}Metadescription{/block}">
	<base href="{$smarty.const.BASE_URL}">

	<link rel="stylesheet" href="htdocs/css/all.css"/>
	<script src="htdocs/js/jquery/jquery-1.12.0.min.js"></script>
	<script src="htdocs/js/jquery/jquery-ui.min.js"></script>
	<script src="htdocs/js/jquery/datepicker-{LanguageHelper::get_language()|strtolower}.js"></script>
	<script src="htdocs/js/summary.js"></script>

	<script type="text/javascript">
		var BASE_URL = "{$smarty.const.BASE_URL}";
		var LANG = {json_encode($lang)};

		$(document).ready(function(){
			$.datepicker.setDefaults({
				changeMonth:true,
				changeYear:true,
				minDate: "-2Y",
				maxDate: "+0D",
				dateFormat:'dd.mm.yy',
				regional:"{LanguageHelper::get_language()|strtolower}"
			});

			$(".datepicker-input" ).datepicker();
		});
		{block name="javascript"}{/block}
	</script>
</head>
<body>
<div id="header">
	<div id="header-content">
		<ul class="ignore-timeless header-menu">
			{if SessionHelper::is_logged_in()}
				<li><a href="summary">{$lang['menu_summary']}</a></li>
				<li><a href="summary/add">{$lang['menu_summary_add']}</a></li>
				<li class="avatar-section">
					<a href="home/logout" class="logout-link">Logout</a>
					<img src="{AvatarHelper::get_avatar_url(SessionHelper::get_session_user()->avatar_name)}" class="avatar" alt="Avatar">
				</li>
			{else}
				<li><a href="home">Home</a></li>
				<li class="f-right"><a href="home/login">Login</a></li>
			{/if}
		</ul>
	</div>
</div>
<div id="main">
	{block name="page-headline-wrap"}<h2 class="page-headline">{block name="page-headline"}{/block}</h2>{/block}
	{block name="errors"}{if (isset($errors) && !empty($errors))}<ul id="errors" class="error-container">{foreach $errors as $error}<li>{$error}</li>{/foreach}</li></ul>{/if}{/block}
	{block name="content"}{/block}
</div>

</body>
</html>