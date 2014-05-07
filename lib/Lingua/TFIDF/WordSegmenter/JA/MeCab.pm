package Lingua::TFIDF::WordSegmenter::JA::MeCab;

# ABSTRACT: Word segmenter for Japanese documents

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

=head1 SYNOPSIS

  use utf8;
  use Lingua::TFIDF::WordSegmenter::JA::MeCab;
  
  my $segmenter = Lingua::TFIDF::WordSegmenter::JA::MeCab->new;
  my $iter = $segmenter->segment('思い出せ、思い出せ　11月5日を...');
  while (defined(my $word = $iter->())) { ... }

=head1 DESCRIPTION

This class is a word segmenter for documents written in Japanese.

=head1 METHODS

=head2 new([ mecab => Text::MeCab->new ])

Constructor.

=head2 segment($document | \$document)

Executes word segmentation on given C<$document> and returns an word iterator.

=head1 SEE ALSO

L<Text::MeCab>

=cut
