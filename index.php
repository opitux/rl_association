<?php
define('RL_ROOT', '../');
include RL_ROOT.'configRL.php';
define('PUN_ROOT', '../'.folder_forum.'/');
include PUN_ROOT.'include/common.php';

define('PUN_TURN_OFF_MAINT', 1);
define('PUN_QUIET_VISIT', 1);

$maintenance = 0;

switch ($maintenance) {
	case 0:
		header('Location: galette/');
		break;

	case 1:
		if ( $pun_user['group_id'] == 1 || $pun_user['group_id'] == 28 ) {
			header('Location: galette/');
			} else {

			$redirect = '<html>';
			$redirect .= '<head>';
			$redirect .= '<title>Site en maintenance</title>';
			$redirect .= '<meta http-equiv="refresh" content="5;URL=' . folder_rl  . '/' . folder_forum . '/" />';
			$redirect .= '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />';
			$redirect .= '<link rel="stylesheet" type="text/css" href="' . folder_rl  . '/' . folder_forum . '/style/RL_Clair.css" />';
			$redirect .= '</head>';
			$redirect .= '<body>';

			$redirect .= '<div id="punredirect" class="pun">';
			$redirect .= '<!-- BEGIN HEADER RL -->';
			$redirect .= '<img src="' . folder_rl  . '/tpl/img/logo.png" />';
			$redirect .= '<!-- END RL -->';
			$redirect .= '<div class="top-box"></div>';
			$redirect .= '<div class="punwrap">';
			$redirect .= '<div id="brdmain">';
			$redirect .= '<div class="block">';
			$redirect .= '	<h2>Redirection</h2>';
			$redirect .= '	<div class="box">';
			$redirect .= '		<div class="inbox">';
			$redirect .= '			<p>';
			$redirect .= '			<b>Site en maintenance</b>.<br />';
			$redirect .= '			Le plate-forme association sera bientôt de retour.<br />Vous allez être rédirigé vers le forum...<br /><br />';
			$redirect .= '			<a href="' . folder_rl  . '/' . folder_forum . '/login.php">Cliquez ici si vous ne voulez pas attendre (ou si votre navigateur ne vous redirige pas automatiquement).</a>';
			$redirect .= '			</p>';
			$redirect .= '		</div>';
			$redirect .= '	</div>';
			$redirect .= '</div>';
			$redirect .= '</div>';
			$redirect .= '</div>';
			$redirect .= '<div class="end-box"></div>';
			$redirect .= '</div>';

			$redirect .= '</body>';
			$redirect .= '</html>';

			echo $redirect;

			}

		break;

	default:
		header('Location: galette/');
		break;
}
