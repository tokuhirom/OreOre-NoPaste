package NoPaste::Web::Dispatcher;
use strict;
use warnings;

use Amon2::Web::Dispatcher::Lite;
use Data::UUID;

my $uuid = Data::UUID->new();

any '/' => sub {
    my ($c) = @_;
    $c->render('index.tt');
};

post '/post' => sub {
    my ($c) = @_;
    if (my $body = $c->req->param('body')) {
        my $entry_id = $uuid->create_str();
        $c->dbh->insert(
            entry => {
                entry_id => $entry_id,
                body     => $body,
            }
        );
        $c->redirect("/entry/$entry_id");
    } else {
        $c->show_error('entry body is empty');
    }
};

get '/entry/{entry_id}' => sub {
    my ($c, $args) = @_;
    my $entry_id = $args->{entry_id} // die;
    my ($body) = $c->dbh->selectrow_array(
        q{SELECT body FROM entry WHERE entry_id=?}, {}, $entry_id
    );
    return $c->res_404() unless $body;
    return $c->render('show.tt', { body => $body });
};

1;
