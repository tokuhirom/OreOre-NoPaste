package OreOre::NoPaste::Web::Dispatcher;
use Amon::Web::Dispatcher::Lite -base;
use Data::UUID;
use Encode;

my $uuid_gen = Data::UUID->new;

get '/' => sub {
    render("index.mt");
};

post '/post' => sub {
    if (my $body = param_decoded("body")) {
        my $uuid = $uuid_gen->create_str();
        my $sth = db->prepare("INSERT INTO entry (id, body) values (?, ?)") or die db->errstr;
        $sth->execute($uuid, $body) or die db->errstr;
        return redirect("/entry/$uuid");
    } else {
        return redirect('/');
    }
};

get '/entry/{entry_id}' => sub {
    my ($c, $args) = @_;
    my $id = $args->{entry_id};

    if ($id) {
        my $sth = db->prepare('SELECT body FROM entry WHERE id=?') or die db->errstr;
        $sth->execute($id) or die db->errstr;
        my ($body) = $sth->fetchrow_array();
        if ($body) {
            return render('show.mt', $body);
        } else {
            return res_404();
        }
    } else {
        return res_404();
    }
};

1;
