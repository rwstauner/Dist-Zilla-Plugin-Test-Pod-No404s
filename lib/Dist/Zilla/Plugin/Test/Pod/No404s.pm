# vim: set ts=2 sts=2 sw=2 expandtab smarttab:
package Dist::Zilla::Plugin::Test::Pod::No404s;
# ABSTRACT: undef

use strict;
use warnings;
use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';

__PACKAGE__->meta->make_immutable;
no Moose;

1;

=head1 SYNOPSIS

=head1 DESCRIPTION

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
