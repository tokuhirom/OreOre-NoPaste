package OreOre::NoPaste::Web::Dispatcher;
use Amon::Web::Dispatcher::Lite -base;
use Data::UUID;
use Encode;

my $uuid_gen = Data::UUID->new;

get '/' => sub {
    render("index.tx");
};

post '/post' => sub {
    my $body = param_decoded("body")
        or return redirect('/');

    my $uuid = $uuid_gen->create_str();
    my $sth = db->insert(
        entry => {
            id => $uuid,
            body => $body,
        }
    );
    return redirect("/entry/$uuid");
};

get '/entry/{entry_id}' => sub {
    my ($c, $args) = @_;
    my $entry_id = $args->{entry_id}
        or return res_404();

    my $entry = db->single(
        entry => {
            id => $entry_id,
        }
    );
    return res_404() unless $entry;

    return render('show.tx', {body => $entry->body});
};

1;
