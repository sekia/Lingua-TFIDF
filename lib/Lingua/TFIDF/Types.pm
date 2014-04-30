package Lingua::TFIDF::Types;

use strict;
use warnings;
use Mouse::Util::TypeConstraints;

subtype 'Lingua::TFIDF::TermFrequency', as 'HashRef[Str]';

duck_type 'Lingua::TFIDF::WordSegmenter' => [qw/segment/];

no Mouse::Util::TypeConstraints;

1;
