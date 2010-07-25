package NoPaste::Web::C;
use strict;
use warnings;
use utf8;
use Router::Simple::Sinatraish;
use Data::UUID;
use Encode;

my $uuid_gen = Data::UUID->new();

get '/' => sub {
    my ($c) = @_;
    $c->render('index.tx');
};

post '/post' => sub {
    my ($c) = @_;
    my $body = decode_utf8($c->req->param('body'));
    my $uuid = $uuid_gen->create_str();
    $c->db->insert(
        entry => {
            id   => $uuid,
            body => $body,
        },
    );
    return $c->res->redirect("/entry/$uuid");
};

get '/entry/{entry_id}' => sub {
    my ($c, $args) = @_;
    my $entry_id = $args->{entry_id}
        or return $c->res->not_found;

    my $entry = $c->db->single(
        entry => {
            id => $entry_id,
        }
    );
    return $c->res->not_found() unless $entry;

    return $c->render('show.tx', {body => $entry->body});
};

1;

