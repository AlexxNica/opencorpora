{* Smarty *}
<html>
<head>
<meta http-equiv='content' content='text/html;charset=utf-8'/>
<link rel='stylesheet' type='text/css' href='{$web_prefix}/css/main.css'/>
</head>
<body>
</body>
{include file='header.tpl'}
<div id='content'>
    <p>Всего {$stats.cnt_g} граммем в {$stats.cnt_gt} группах, {$stats.cnt_l} лемм, {$stats.cnt_f} форм в индексе (не проверено {$stats.cnt_r} ревизий).</p>
    <p><a href="?act=gram">Редактор граммем</a><br/>
    <a href="?act=lemmata">Редактор лемм</a></p>
</div>
<div id='rightcol'>
{include file='right.tpl'}
</div>
</body>
</html>
