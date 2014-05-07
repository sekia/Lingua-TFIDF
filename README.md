Lingua-TFIDF
===

This is just another TF-IDF calculator for Perl 5.

Quoting [Wikipedia](http://en.wikipedia.org/wiki/Tf%E2%80%93idf):

> tf–idf, short for term frequency–inverse document frequency, is a numerical statistic that is intended to reflect how important a word is to a document in a collection or corpus. It is often used as a weighting factor in information retrieval and text mining.

I know that CPAN has several TF-IDF calculator modules already, like Text::TFIDF and Lingua::JA::TFIDF. So why I reinvented the wheel? The reason is language dependency: Text::TFIDF assumes that words in sentence are separated by spaces in spite of that the assumption is not true in most east asian languages. And Lingua::JA::TFIDF works only on documents written in Japanese.

Lingua::TFIDF solves this problem by separating the process into 2 parts: word segmentation and word frequency counting. By supplying a language-specific word segmenter, this class can calculate TF-IDF on documents written in any languages.

Example
---

```perl
#!/usr/bin/env perl

use strict;
use warnings;
use Lingua::TFIDF;
use Lingua::TFIDF::WordSegmenter::JA::MeCab;

my $tf_idf_calc = Lingua::TFIDF->new(
  word_segmenter => Lingua::TFIDF::WordSegmenter::JA::MeCab->new,
);

my @documents = (<<'EOD1', <<'EOD2');
ハンプティ・ダンプティ　塀の上
ハンプティ・ダンプティ　落っこちた
...
EOD1
思い出せ　思い出せ　11月5日を
火薬陰謀事件と反逆を
...
EOD2

my $tf = $tf_idf_calc->tf(document => $documents[0], normalize => 1);
my $idf = $tf_idf_calc->idf(documents => \@documents);
my $tf_idf = $tf_idf_calc->tf_idf(documents => \@documents, normalize => 1);
```

License
---

The MIT License (MIT)

Copyright (c) 2014 Koichi SATOH, all rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
