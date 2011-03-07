use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use NoPaste::Web;
use Plack::Builder;

builder {
    enable 'Plack::Middleware::Static',
        path => qr{^/static/},
        root => './htdocs/';
    enable 'Plack::Middleware::ReverseProxy';
    NoPaste::Web->to_app();
};
