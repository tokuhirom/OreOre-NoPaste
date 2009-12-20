package OreOre::NoPaste::Web::Dispatcher;
use Amon::Web::Dispatcher;
use feature 'switch';

sub dispatch {
    my ($class, $req) = @_;
    given ([$req->method, $req->path_info]) {
        when (['GET', '/']) {
            call("Root", 'index');
        }
        when (['POST', '/post']) {
            call("Root", 'post');
        }
        when (['GET', qr{^/entry/(.+)$}]) {
            call("Root", 'show', $1);
        }
        default {
            res_404();
        }
    }
}

1;
