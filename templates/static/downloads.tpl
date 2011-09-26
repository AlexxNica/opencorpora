{* Smarty *}
{extends file='common.tpl'}
{block name='content'}
<h1>{t}Материалы для скачивания{/t}</h1>
<h2>{t}Размеченные тексты{/t}</h2>
<p>XML, {t}обновлён{/t} {$dl.annot.xml.updated}
<ul>
<li><a href="{$web_prefix}/files/export/annot/annot.opcorpora.xml.bz2">архив .bz2</a> ({$dl.annot.xml.bz2.size} {t}Мб{/t})</li>
<li><a href="{$web_prefix}/files/export/annot/annot.opcorpora.xml.zip">архив .zip</a> ({$dl.annot.xml.zip.size} {t}Мб{/t})</li>
</ul>
<h2>Частотные списки</h2>
<h3>Униграммы (однословия)</h3>
<table border='1' cellspacing='0' cellpadding='3'>
<tr class='small'>
    <th>&nbsp;</th>
    <th>Леммы</th>
    <th>Учёт регистра</th>
    <th>Только слова*</th>
    <th colspan='3'>&nbsp;</th>
    <th>Обновлено</th>
</tr>
<tr>
    <td>exact_cyr_lc</td>
    <td align='center'>&mdash;</td>
    <td align='center'>&mdash;</td>
    <td align='center'>+</td>
    <td><a href="{$web_prefix}/files/export/ngrams/unigrams.cyr.lc.bz2">архив .bz2</a> ({$dl.ngram.1.exact_cyr_lc.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/unigrams.cyr.lc.zip">архив .zip</a> ({$dl.ngram.1.exact_cyr_lc.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=1_exact_cyr_lc">top100</a></td>
    <td>{$dl.ngram.1.exact_cyr_lc.updated}</td>
</tr>
<tr>
    <td>exact_cyr</td>
    <td align='center'>&mdash;</td>
    <td align='center'>+</td>
    <td align='center'>+</td>
    <td><a href="{$web_prefix}/files/export/ngrams/unigrams.cyr.bz2">архив .bz2</a> ({$dl.ngram.1.exact_cyr.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/unigrams.cyr.zip">архив .zip</a> ({$dl.ngram.1.exact_cyr.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=1_exact_cyr">top100</a></td>
    <td>{$dl.ngram.1.exact_cyr.updated}</td>
</tr>
<tr>
    <td>exact_lc</td>
    <td align='center'>&mdash;</td>
    <td align='center'>&mdash;</td>
    <td align='center'>&mdash;</td>
    <td><a href="{$web_prefix}/files/export/ngrams/unigrams.lc.bz2">архив .bz2</a> ({$dl.ngram.1.exact_lc.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/unigrams.lc.zip">архив .zip</a> ({$dl.ngram.1.exact_lc.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=1_exact_lc">top100</a></td>
    <td>{$dl.ngram.1.exact_lc.updated}</td>
</tr>
<tr>
    <td>exact</td>
    <td align='center'>&mdash;</td>
    <td align='center'>+</td>
    <td align='center'>&mdash;</td>
    <td><a href="{$web_prefix}/files/export/ngrams/unigrams.bz2">архив .bz2</a> ({$dl.ngram.1.exact.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/unigrams.zip">архив .zip</a> ({$dl.ngram.1.exact.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=1_exact">top100</a></td>
    <td>{$dl.ngram.1.exact.updated}</td>
</tr>
</table>
<h3>Биграммы (двусловия)</h3>
<table border='1' cellspacing='0' cellpadding='3'>
<tr class='small'>
    <th>&nbsp;</th>
    <th>Леммы</th>
    <th>Учёт регистра</th>
    <th>Только слова*</th>
    <th colspan='3'>&nbsp;</th>
    <th>Обновлено</th>
</tr>
<tr>
    <td>exact_cyrA_lc</td>
    <td align='center'>&mdash;</td>
    <td align='center'>&mdash;</td>
    <td align='center'>+ (A**)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.cyrA.lc.bz2">архив .bz2</a> ({$dl.ngram.2.exact_cyrA_lc.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.cyrA.lc.zip">архив .zip</a> ({$dl.ngram.2.exact_cyrA_lc.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=2_exact_cyrA_lc">top100</a></td>
    <td>{$dl.ngram.2.exact_cyrA_lc.updated}</td>
</tr>
<tr>
    <td>exact_cyrB_lc</td>
    <td align='center'>&mdash;</td>
    <td align='center'>&mdash;</td>
    <td align='center'>+ (B**)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.cyrB.lc.bz2">архив .bz2</a> ({$dl.ngram.2.exact_cyrB_lc.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.cyrB.lc.zip">архив .zip</a> ({$dl.ngram.2.exact_cyrB_lc.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=2_exact_cyrB_lc">top100</a></td>
    <td>{$dl.ngram.2.exact_cyrB_lc.updated}</td>
</tr>
<tr>
    <td>exact_cyrA</td>
    <td align='center'>&mdash;</td>
    <td align='center'>+</td>
    <td align='center'>+ (A**)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.cyrA.bz2">архив .bz2</a> ({$dl.ngram.2.exact_cyrA.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.cyrA.zip">архив .zip</a> ({$dl.ngram.2.exact_cyrA.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=2_exact_cyrA">top100</a></td>
    <td>{$dl.ngram.2.exact_cyrA.updated}</td>
</tr>
<tr>
    <td>exact_cyrB</td>
    <td align='center'>&mdash;</td>
    <td align='center'>+</td>
    <td align='center'>+ (B**)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.cyrB.bz2">архив .bz2</a> ({$dl.ngram.2.exact_cyrB.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.cyrB.zip">архив .zip</a> ({$dl.ngram.2.exact_cyrB.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=2_exact_cyrB">top100</a></td>
    <td>{$dl.ngram.2.exact_cyrB.updated}</td>
</tr>
<tr>
    <td>exact_lc</td>
    <td align='center'>&mdash;</td>
    <td align='center'>&mdash;</td>
    <td align='center'>&mdash;</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.lc.bz2">архив .bz2</a> ({$dl.ngram.2.exact_lc.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.lc.zip">архив .zip</a> ({$dl.ngram.2.exact_lc.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=2_exact_lc">top100</a></td>
    <td>{$dl.ngram.2.exact_lc.updated}</td>
</tr>
<tr>
    <td>exact</td>
    <td align='center'>&mdash;</td>
    <td align='center'>+</td>
    <td align='center'>&mdash;</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.bz2">архив .bz2</a> ({$dl.ngram.2.exact.bz2.size} Мб)</td>
    <td><a href="{$web_prefix}/files/export/ngrams/bigrams.zip">архив .zip</a> ({$dl.ngram.2.exact.zip.size} Мб)</td>
    <td><a href="?page=top100&amp;type=2_exact">top100</a></td>
    <td>{$dl.ngram.2.exact.updated}</td>
</tr>
</table>
<p class='small'>* Словами мы считаем токены, имеющие в своём составе хотя бы одну кириллическую букву.</p>
<p class='small'>** Тип A: токены, не являющиеся словами, игнорируются, т.е. в биграмму могут входить, например, слова, разделённые запятой. Тип B: никакие токены не игнорируются, но из списка исключаются цепочки, где хотя бы один токен не является словом.</p>
<h2>{t}Морфологический словарь{/t}</h2>
<p>XML, {t}обновлён{/t} {$dl.dict.xml.updated}, см. <a href="{$web_prefix}/?page=export">описание формата</a></p>
<ul>
<li><a href="{$web_prefix}/files/export/dict/dict.opcorpora.xml.bz2">архив .bz2</a> ({$dl.dict.xml.bz2.size} {t}Мб{/t})</li>
<li><a href="{$web_prefix}/files/export/dict/dict.opcorpora.xml.zip">архив .zip</a> ({$dl.dict.xml.zip.size} {t}Мб{/t})</li>
</ul>
<p>Plain text, {t}обновлён{/t} {$dl.dict.txt.updated}</p>
<ul>
<li><a href="{$web_prefix}/files/export/dict/dict.opcorpora.txt.bz2">архив .bz2</a> ({$dl.dict.txt.bz2.size} {t}Мб{/t})</li>
<li><a href="{$web_prefix}/files/export/dict/dict.opcorpora.txt.zip">архив .zip</a> ({$dl.dict.txt.zip.size} {t}Мб{/t})</li>
</ul>
{/block}
