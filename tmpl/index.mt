? extends 'base.mt';
? block title => 'amon page';
? block content => sub {
<form method="post" action="/post">
<textarea rows="20" cols="60"></textarea>
<input type="submit" value="post" />
</form>
? };
