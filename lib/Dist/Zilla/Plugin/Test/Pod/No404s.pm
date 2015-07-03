# vim: set ts=2 sts=2 sw=2 expandtab smarttab:
use strict;
use warnings;

package Dist::Zilla::Plugin::Test::Pod::No404s;
# ABSTRACT: Add release tests for POD HTTP links

use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::PrereqSource';

sub register_prereqs {
  my $self = shift;

  $self->zilla->register_prereqs(
    {
        type  => 'requires',
        phase => 'develop',
    },
    'Test::Pod::No404s' => '0',
  );
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

=for Pod::Coverage
register_prereqs

=head1 SYNOPSIS

  # dist.ini
  [Test::Pod::No404s]

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>
providing the following files:

  xt/release/pod-no404s.t - a standard Test::Pod::No404s test

You can skip the test by setting
C<$ENV{SKIP_POD_NO404S}>
or
C<$ENV{AUTOMATED_TESTING}>.

I elected to skip the 404 test with C<AUTOMATED_TESTING>
because I don't want to run that test (and bother the network) often,
but I do like to run my author and release tests
before actually attempting C<dzil release>.

So using C<dzil smoke> instead of C<dzil test>
will skip the 404 network tests.

=head1 SEE ALSO

=for :list
* L<Test::Pod::No404s>

=cut

__DATA__
___[ xt/release/pod-no404s.t ]___
#!perl

use strict;
use warnings;
use Test::More;

foreach my $env_skip ( qw(
  SKIP_POD_NO404S
  AUTOMATED_TESTING
) ){
  plan skip_all => "\$ENV{$env_skip} is set, skipping"
    if $ENV{$env_skip};
}

eval "use Test::Pod::No404s";
if ( $@ ) {
  plan skip_all => 'Test::Pod::No404s required for testing POD';
}
else {
  all_pod_files_ok();
}
