package OreOre::NoPaste::Web::Dispatcher;
use Amon::Web::Dispatcher;
use feature 'switch';

sub dispatch {
    my ($class, $req) = @_;
    given ($req->path_info) {
        when ('/') {
            call("Root", 'index');
        }
        when ('/post') {
            call("Root", 'post');
        }
        when (qr{^/entry/(.+)$}) {
            call("Root", 'show', $1);
        }
        default {
            res_404();
        }
    }
}

1;
