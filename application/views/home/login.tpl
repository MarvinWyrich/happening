{extends file="../layout/layout.tpl"}
{block name=title}Login{/block}
{block name=id}home/index{/block}
{block name=description}Login{/block}

{block name="page-headline"}Login{/block}
{block name=content}
	<div class="row">
		<div class="col span-1-2">
			<form action="home/login" method="post">
				<div class="row">
					<div class="col">
						<label for="login-username">{$lang['label_username']}</label>
						<input type="text" name="username" id="login-username">
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="login-password">{$lang['label_password']}</label>
						<input type="password" name="password" id="login-password">
					</div>
				</div>
				<div class="button-row">
					<input type="submit" value="login" class="primary-button">
				</div>
			</form>
		</div>
	</div>
{/block}