? my $body = shift;
? extends 'base.mt';
? block title => 'No Paste!';
? block content => sub {
<pre><?= $body ?></pre>
? };
