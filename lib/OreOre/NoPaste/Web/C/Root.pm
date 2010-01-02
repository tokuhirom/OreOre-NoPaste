package OreOre::NoPaste::Web::C::Root;
use Amon::Web::C;
use Data::UUID;
use Encode;

my $uuid_gen = Data::UUID->new;

sub index {
    render("index.mt");
}

sub post {
    if (my $body = param_decoded("body")) {
        my $uuid = $uuid_gen->create_str();
        my $dbh = model("DB")->dbh;
        my $sth = $dbh->prepare("INSERT INTO entry (id, body) values (?, ?)") or die $dbh->errstr;
        $sth->execute($uuid, $body) or die $dbh->errstr;
        return redirect("/entry/$uuid");
    } else {
        return redirect('/');
    }
}

sub show {
    my ($class, $id) = @_;

    if ($id) {
        my $dbh = model("DB")->dbh;
        my $sth = $dbh->prepare('SELECT body FROM entry WHERE id=?') or die $dbh->errstr;
        $sth->execute($id) or die $dbh->errstr;
        my ($body) = $sth->fetchrow_array();
        if ($body) {
            return render('show.mt', $body);
        } else {
            return res_404();
        }
    } else {
        return res_404();
    }
}

1;
