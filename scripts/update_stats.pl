#!/usr/bin/perl
use strict;
use utf8;
use DBI;
use Encode;
use POSIX qw/strftime/;
use Config::INI::Reader;

my $lock_path = "/var/lock/opcorpora_updstats.lock";
if (-f $lock_path) {
    die ("lock exists, exiting");
}

#reading config
my $conf = Config::INI::Reader->read_file($ARGV[0]);
$conf = $conf->{mysql};

open my $lock, ">$lock_path";
print $lock 'lock';
close $lock;

my $dbh = DBI->connect('DBI:mysql:'.$conf->{'dbname'}.':'.$conf->{'host'}, $conf->{'user'}, $conf->{'passwd'}) or die $DBI::errstr;
$dbh->do("SET NAMES utf8");
my $scan = $dbh->prepare("SELECT * FROM `stats_param` WHERE is_active=1 ORDER BY param_id");
my $insert = $dbh->prepare("INSERT INTO `stats_values` VALUES(?, ?, ?)");
my $scan_author = $dbh->prepare("SELECT user_id, timestamp FROM sentence_authors WHERE sent_id=? LIMIT 1");
my $insert_author = $dbh->prepare("INSERT INTO sentence_authors VALUES(?, ?, ?)");

$scan->execute();

# SUBROUTINES

my $func;

sub books_by_source {
    my $pid = shift;
    my $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM books WHERE parent_id IN (SELECT book_id FROM books WHERE parent_id=$pid)");
    $sc->execute();
    my $cnt = $sc->fetchrow_hashref()->{'cnt'};
    return $cnt if $cnt;

    $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM books WHERE parent_id=$pid");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
}

sub sentences_by_source {
    my $pid = shift;
    my $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM sentences WHERE par_id IN (SELECT par_id FROM paragraphs WHERE book_id IN (SELECT book_id FROM books WHERE parent_id = $pid OR parent_id IN (SELECT book_id FROM books WHERE parent_id=$pid) OR parent_id IN (SELECT book_id FROM books WHERE parent_id IN(SELECT book_id FROM books WHERE parent_id = $pid))))");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
}

sub tokens_by_source {
    my $pid = shift;
    my $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM text_forms WHERE sent_id IN (SELECT sent_id FROM sentences WHERE par_id IN (SELECT par_id FROM paragraphs WHERE book_id IN (SELECT book_id FROM books WHERE parent_id = $pid OR parent_id IN (SELECT book_id FROM books WHERE parent_id = $pid) OR parent_id IN (SELECT book_id FROM books WHERE parent_id IN(SELECT book_id FROM books WHERE parent_id = $pid)))))");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
}

sub words_by_source {
    my $pid = shift;
    my $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM text_forms WHERE sent_id IN (SELECT sent_id FROM sentences WHERE par_id IN (SELECT par_id FROM paragraphs WHERE book_id IN (SELECT book_id FROM books WHERE parent_id = $pid OR parent_id IN (SELECT book_id FROM books WHERE parent_id = $pid) OR parent_id IN (SELECT book_id FROM books WHERE parent_id IN(SELECT book_id FROM books WHERE parent_id = $pid))))) AND tf_text REGEXP '[А-Яа-яЁё]'");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
}

sub get_sentence_adder {
    my $sid = shift;
    my $r;

    $scan_author->execute($sid);
    if ($r = $scan_author->fetchrow_hashref()) {
        return $r;
    }

    my $sc = $dbh->prepare("
        SELECT user_id, timestamp
        FROM rev_sets
        WHERE set_id = (
            SELECT set_id
            FROM tf_revisions
            WHERE tf_id IN (
                SELECT tf_id
                FROM text_forms
                WHERE sent_id=?
            )
            ORDER BY rev_id
            LIMIT 1
        )
        LIMIT 1
    ");
    $sc->execute($sid);
    $r = $sc->fetchrow_hashref();
    $insert_author->execute($sid, $r->{'user_id'}, $r->{'timestamp'});
    return $r;
}

$func->{'total_books'} = sub {
    my $sc = $dbh->prepare("SELECT COUNT(DISTINCT book_id) AS cnt FROM paragraphs");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
};
$func->{'chaskor_books'} = sub {
    return books_by_source(1);
};
$func->{'chaskor_news_books'} = sub {
    return books_by_source(226);
};
$func->{'wikipedia_books'} = sub {
    return books_by_source(8);
};
$func->{'wikinews_books'} = sub {
    return books_by_source(56);
};
$func->{'blogs_books'} = sub {
    return books_by_source(184);
};
$func->{'fiction_books'} = sub {
    return books_by_source(806);
};
$func->{'total_sentences'} = sub {
    my $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM sentences");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
};
$func->{'chaskor_sentences'} = sub {
    return sentences_by_source(1);
};
$func->{'chaskor_news_sentences'} = sub {
    return sentences_by_source(226);
};
$func->{'wikipedia_sentences'} = sub {
    return sentences_by_source(8);
};
$func->{'wikinews_sentences'} = sub {
    return sentences_by_source(56);
};
$func->{'blogs_sentences'} = sub {
    return sentences_by_source(184);
};
$func->{'fiction_sentences'} = sub {
    return sentences_by_source(806);
};
$func->{'total_tokens'} = sub {
    my $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM text_forms");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
};
$func->{'chaskor_tokens'} = sub {
    return tokens_by_source(1);
};
$func->{'chaskor_news_tokens'} = sub {
    return tokens_by_source(226);
};
$func->{'wikipedia_tokens'} = sub {
    return tokens_by_source(8);
};
$func->{'wikinews_tokens'} = sub {
    return tokens_by_source(56);
};
$func->{'blogs_tokens'} = sub {
    return tokens_by_source(184);
};
$func->{'fiction_tokens'} = sub {
    return tokens_by_source(806);
};
$func->{'total_lemmata'} = sub {
    my $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM dict_lemmata");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
};
$func->{'total_words'} = sub {
    my $sc = $dbh->prepare("SELECT COUNT(*) AS cnt FROM text_forms WHERE tf_text REGEXP '[А-Яа-яЁё]'");
    $sc->execute();
    return $sc->fetchrow_hashref()->{'cnt'};
};
$func->{'chaskor_words'} = sub {
    return words_by_source(1);
};
$func->{'chaskor_news_words'} = sub {
    return words_by_source(226);
};
$func->{'wikipedia_words'} = sub {
    return words_by_source(8);
};
$func->{'wikinews_words'} = sub {
    return words_by_source(56);
};
$func->{'blogs_words'} = sub {
    return words_by_source(184);
};
$func->{'fiction_words'} = sub {
    return words_by_source(806);
};
$func->{'added_sentences'} = sub {

    #find the authors of all sentences which haven't been found yet
    my $absent = $dbh->prepare("SELECT sent_id FROM sentences WHERE sent_id NOT IN (SELECT sent_id FROM sentence_authors)");
    $absent->execute();
    my $r;

    print STDERR "Catching up with new sentences...\n";
    while ($r = $absent->fetchrow_hashref()) {
        get_sentence_adder($r->{'sent_id'});
    }
    print STDERR "Done.\n";

    my $ins = $dbh->prepare("INSERT INTO user_stats VALUES(?, ?, ?, ?)");
    my $del = $dbh->prepare("DELETE FROM user_stats WHERE param_id=?");

    #LAST WEEK
    #we'll use param_id = 7, though it's used in different sense in stats_param
    print STDERR "Counting last week's sentences...";
    my $cnt = $dbh->prepare("SELECT user_id, COUNT(sent_id) as cnt FROM sentence_authors WHERE timestamp>=? GROUP BY user_id");

    my $basic_ts = time()-60*60*24*7;
    print STDERR "    will count sentences not older than UNIX $basic_ts\n";

    $cnt->execute($basic_ts);
    $del->execute(7);
    while ($r = $cnt->fetchrow_hashref()) {
        $ins->execute($r->{'user_id'}, time(), 7, $r->{'cnt'});
    }
    print STDERR "    done.\n";

    #GLOBAL
    print STDERR "Counting all sentences... ";
    $cnt->execute(0);
    $del->execute(6);
    while ($r = $cnt->fetchrow_hashref()) {
        $ins->execute($r->{'user_id'}, time(), 6, $r->{'cnt'});
    }
    print STDERR "Done.\n";
    return -1;
};

# /SUBROUTINES

my $value;
while (my $ref = $scan->fetchrow_hashref()) {
    if (exists $func->{$ref->{'param_name'}}) {
        $value = $func->{$ref->{'param_name'}}->();
        $insert->execute(time(), $ref->{'param_id'}, $value) unless $value == -1;
    }
}

unlink ($lock_path);
