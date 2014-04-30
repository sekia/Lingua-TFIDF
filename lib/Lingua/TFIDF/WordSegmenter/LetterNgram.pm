package Lingua::TFIDF::WordSegmenter::LetterNgram;

use strict;
use warnings;
use Carp qw//;
use Smart::Args;

sub new {
  args
    my $class => 'ClassName',
    my $n => 'Int';

  Carp::croak('Word length must be 1+.') if $n <= 0;

  bless +{ n => $n } => $class;
}

sub n { $_[0]->{n} }

sub segment {
  args_pos
    my $self,
    my $document => 'Ref | Str';

  $document = \"$document" unless ref $document;

  my $length = length $$document;
  my $index = -1;
  my $n = $self->n;
  sub {
  GET_NEXT_NGRAM:
    {
      ++$index;
      return if $index + $n > $length;

      my $ngram = substr $$document, $index, $n;
      redo GET_NEXT_NGRAM if $ngram =~ /\s/;
      return $ngram;
    }
  };
}

1;
