<?php

/* OPITUX */
define('RL_ROOT', '../');
include RL_ROOT.'configRL.php';
define('PUN_ROOT', '../'.folder_forum.'/');
include PUN_ROOT.'include/common.php';

define('PUN_TURN_OFF_MAINT', 1);
define('PUN_QUIET_VISIT', 1);
?>

<html>
<head>
<title>Redirection</title>
<meta http-equiv="refresh" content="2;URL=<?php echo folder_rl . '/' . folder_forum ?>/login.php" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<?php echo folder_rl . '/' . folder_forum ?>/style/RL_Clair.css" />
</head>
<body>

<div id="punredirect" class="pun">
<!-- BEGIN HEADER RL -->
<img src="<?php echo folder_rl ?>/tpl/img/logo.png" />
<!-- END RL -->
<div class="top-box"></div>
<div class="punwrap">
<div id="brdmain">
<div class="block">
	<h2>Redirection</h2>
	<div class="box">
		<div class="inbox">
			<p>
			Vous devez être identifié au forum pour accéder à ces pages.<br />
			Redirection&#160;…<br /><br />
			<a href="<?php echo folder_rl . '/' . folder_forum ?>/login.php">Cliquez ici si vous ne voulez pas attendre (ou si votre navigateur ne vous redirige pas automatiquement).</a>
			</p>
		</div>
	</div>
</div>
</div>
</div>
<div class="end-box"></div>
</div>

</body>
</html>
