package Lingua::TFIDF::WordCounter::Simple;

use strict;
use warnings;
use Smart::Args;

sub new { bless +{ frequencies => +{} } => $_[0] }

sub add_count {
  args_pos
    my $self,
    my $word => 'Str';

  ++$self->{frequencies}{$word};
}

sub clear { $_[0]->{frequencies} = +{} }

sub frequencies { $_[0]->{frequencies} }

1;
