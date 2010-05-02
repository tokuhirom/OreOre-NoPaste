package Text::Xslate::Syntax::Metakolon;
use 5.010;
use Mouse;

extends qw(Text::Xslate::Parser);

# [% ... %]
sub _build_line_start { qr/\Q%/xms  }
sub _build_tag_start  { qr/\Q[%/xms }
sub _build_tag_end    { qr/\Q%]/xms }

no Mouse;
__PACKAGE__->meta->make_immutable();

__END__

=head1 NAME

Text::Xslate::Syntax::Metakolon - The same as Kolon but using [% ... %] tags

=head1 SYNOPSIS

    use Text::Xslate;
    my $tx = Text::Xslate->new(
        syntax => 'Metakolon',
        string => 'Hello, [% $dialect %] world!',
    );

    print $tx->render({ dialect => 'Metakolon' });

=head1 DESCRIPTION

Metakolon is the same as Kolon except for using C<< [% ... %] >> tags and
C<< % ... >> line code, instead of C<< <: ... :> >> and C<< : ... >>.

This may be useful when you want to produce Xslate templates by itself.

See L<Text::Xslate::Syntax::Kolon> for details.

=head1 SEE ALSO

L<Text::Xslate>

=cut
