package Lingua::TFIDF::WordSegmenter::JA::MeCab;

use strict;
use warnings;
use Encode qw//;
use Smart::Args;
use Text::MeCab;

my $mecab_encoding = Encode::find_encoding(Text::MeCab::ENCODING);

sub new {
  args
    my $class => 'ClassName',
    my $mecab => +{ isa => 'Text::MeCab', optional => 1 };

  $mecab = Text::MeCab->new unless defined $mecab;
  bless +{ mecab => $mecab } => $class;
}

sub mecab { $_[0]->{mecab} }

sub segment {
  args_pos
    my $self,
    my $document => 'Ref | Str';

  my $input = $mecab_encoding->encode(ref $document ? $$document : $document);
  my $node = $self->mecab->parse($input);
  sub {
    return unless $node and $node->stat != Text::MeCab::MECAB_EOS_NODE;
    my $word = $mecab_encoding->decode($node->surface);
    $node = $node->next;
    return $word;
  };
}

1;
