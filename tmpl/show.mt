? my $body = shift;
? extends 'base.mt';
? block title => 'amon page';
? block content => sub {
<pre><?= $body ?></pre>
? };
