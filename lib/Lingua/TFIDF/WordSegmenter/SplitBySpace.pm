package Lingua::TFIDF::WordSegmenter::SplitBySpace;

use strict;
use warnings;
use Smart::Args;

sub new {
  args
    my $class => 'ClassName',
    my $lower_case => +{ isa => 'Bool', default => 0 },
    my $remove_punctuations => +{ isa => 'Bool', default => 0 },
    my $stop_words => +{ isa => 'ArrayRef[Str]', default => [] };

  bless +{
    lower_case => $lower_case,
    remove_punctuations => $remove_punctuations,
    stop_words => $stop_words,
  } => $class;
}

sub lower_case { $_[0]->{lower_case} }

sub remove_punctuations { $_[0]->{remove_punctuations} }

sub segment {
  args_pos
    my $self,
    my $document => 'Ref | Str';

  my @words = split /\s+/, ref $document ? $$document : $document;

  @words = map lc, @words if $self->lower_case;

  if ($self->remove_punctuations) {
    s/^\W+|\W+$//g for @words;
  }

  if (@{ $self->stop_words } != 0) {
    my %stop_words = map { ($_ => 1) } @{ $self->stop_words };
    @words = grep { not exists $stop_words{$_} } @words;
  }

  return sub { shift @words };
}

sub stop_words { $_[0]->{stop_words} }

1;
