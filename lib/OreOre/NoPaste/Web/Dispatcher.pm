package OreOre::NoPaste::Web::Dispatcher;
use Amon::Web::Dispatcher;
use feature 'switch';
use 5.010;

sub dispatch {
    my ($class, $req) = @_;
    given ([$req->method, $req->path_info]) {
        when (['GET', '/']) {
            return call("Root", 'index');
        }
        when (['POST', '/post']) {
            return call("Root", 'post');
        }
        when (['GET', qr{^/entry/(.+)$}]) {
            return call("Root", 'show', $1);
        }
        default {
            return res_404();
        }
    }
}

1;
