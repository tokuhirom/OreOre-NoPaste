<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title><? block title => 'NoPaste' ?></title>
    <link href="<?= uri_for('/static/css/main.css') ?>" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
    <div id="Container">
        <div id="Header">
            <a href="<?= uri_for('/') ?>">Yet Another NoPaste Site</a>
        </div>
        <div id="Content"><? block content => 'body here' ?></div>
        <div id="FooterContainer"><div id="Footer">
            <div class="about">OreOre::NoPaste version <?= $OreOre::NoPaste::VERSION ?>, powered by <a href="http://amon.64p.org/">Amon <?= $Amon::VERSION ?></a></div>
            <div class="copyright">Copyright (C) 2009 64p.org</div>
        </div></div>
    </div>
</body>
</html>
