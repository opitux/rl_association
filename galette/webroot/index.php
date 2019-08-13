<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Galette's instanciation and routes
 *
 * PHP version 5
 *
 * Copyright © 2014 The Galette Team
 *
 * This file is part of Galette (http://galette.tuxfamily.org).
 *
 * Galette is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Galette is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Galette. If not, see <http://www.gnu.org/licenses/>.
 *
 * @category  Main
 * @package   Galette
 *
 * @author    Johan Cwiklinski <johan@x-tnd.be>
 * @copyright 2014 The Galette Team
 * @license   http://www.gnu.org/licenses/gpl-3.0.html GPL License 3.0 or (at your option) any later version
 * @version   SVN: $Id$
 * @link      http://galette.tuxfamily.org
 * @since     0.8.2dev 2014-11-11
 */

// define relative base path templating can use
if (!defined('GALETTE_BASE_PATH')) {
    define('GALETTE_BASE_PATH', '../');
}

/* OPITUX */
define('PUN_ROOT', '../../../forum/');
require PUN_ROOT.'include/common.php';
// OPITUX - décommenter les 2 lignes suivantes pour décoréler le site association de la maintenance forum
// define('PUN_TURN_OFF_MAINT', 1);
// define('PUN_QUIET_VISIT', 1);

define("pun_user_email",		$pun_user['email']);
define("pun_user_username",		$pun_user['username']);
define("pun_user_password",		$pun_user['password']);

$pun_user_guest = ($pun_user['is_guest'] ? true : false );
define('pun_user_guest', $pun_user_guest);

if ( pun_user_guest ) {
	require_once('../../../redirect.php');
	exit;
}
/* OPITUX */

/** @ignore */
require_once __DIR__ . '/../includes/main.inc.php';
