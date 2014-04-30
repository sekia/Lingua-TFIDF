package Lingua::TFIDF::WordCounter::Lossy;

use strict;
use warnings;
use Algorithm::LossyCount;
use Smart::Args;

sub new {
  args
    my $class => 'ClassName',
    my $max_error_ratio => 'Num';

  bless +{
    counter => Algorithm::LossyCount->new(max_error_ratio => $max_error_ratio),
    max_error_ratio => $max_error_ratio,
  } => $class;
}

sub add_count {
  args_pos
    my $self,
    my $word => 'Str';

  $self->counter->add_sample($word);
}

sub clear {
  args
    my $self;

  $self->{counter} =
    Algorithm::LossyCount->new(max_error_ratio => $self->max_error_ratio);
}

sub counter { $_[0]->{counter} }

sub frequencies { $_[0]->counter->frequencies }

sub max_error_ratio { $_[0]->{max_error_ratio} }

1;
