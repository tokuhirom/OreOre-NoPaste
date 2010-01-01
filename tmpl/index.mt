? extends 'base.mt';
? block title => 'amon page';
? block content => sub {
<form method="post" action="<?= uri_for('/post') ?>" class="nopaste">
<p class="nm"><textarea name="body" rows="20" cols="60"></textarea></p>
<p class="nm submit-btn"><input type="submit" value="post" /></p>
</form>
? };
