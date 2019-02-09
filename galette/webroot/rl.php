<?

define('PUN_ROOT', '../../../forum/');
require PUN_ROOT.'include/common.php';
define('PUN_TURN_OFF_MAINT', 1);
define('PUN_QUIET_VISIT', 1);

$script ='';
$script .='var SubscribeForm = document.forms.form;';
$script .='  SubscribeForm.elements.pseudo_adh.value = \''.$pun_user['username'].'\';';
$script .='  SubscribeForm.elements.login_adh.value = \''.$pun_user['username'].'\';';
$script .='  SubscribeForm.elements.email_adh.value = \''.$pun_user['email'].'\';';

echo $script ;


echo '
$(window).on(\'load\', function() {

	$( "#info_field_1_1" ).after( "<div class=\'warningbox\' style=\'margin:10px 0;\'>Vous acceptez que l\'association Randonner Léger collecte et utilise les données personnelles que vous venez de renseigner dans ce formulaire pour le but exclusif de sa bonne gestion (conformément à la réglementation RGPD du 25 mai 2018). Ces informations ne seront jamais vendues ou transmises à des tiers.</div>" );
	$( "#info_field_2_1" ).after( "<div class=\'warningbox\' style=\'margin:10px 0;\'>Je reconnais avoir pris connaissance des <a href=\'https://cloud.randonner-leger.org/asso/index.php/s/jAXFXfSKGMAiLrA\' target=\'_blank\'>statuts</a> et <a href=\'https://cloud.randonner-leger.org/asso/index.php/s/tT29xG2t93y2HAy\' target=\'_blank\'>réglement intérieur</a> de l\'association Randonner Léger.</div>" );

});
';

#$("input[name='item_number']").change(function(){
#    var selected_radio = $("input[name='item_number']:checked").val();
#    if (selected_radio == '2'){
#    	$( '#amount' ).val('');
#        $( '#amount' ).attr("placeholder", "Votre cotisation");
#        $( '#amount' ).focus();
#        $( "#amount" ).after( "<div id='paypalbox' class='warningbox' style='margin:10px 0;'><b>Attention&nbsp;:</b><br /> Si vous optez pour une cotisation libre, merci renseigner le champ \"Montant\" ci-dessus<br />La cotisation minimale est fixée à 5 euros.</div>" );
#        return false;
#    }
#    else if (selected_radio == '5')
#    {
#        $( ".warningbox" ).remove();
#        $( ".errorbox" ).remove();
#    	$( '#amount' ).val('');
#        $( '#amount' ).attr("placeholder", "Votre donation");
#        $( '#amount' ).focus();
#    }
#    else
#    {
#        $( ".warningbox" ).remove();
#        $( ".errorbox" ).remove();
#    }
#});

#$(document).ready(function(){
#    $("input[name='submit']").click(function(){
#    var value = $("#amount").val()
#    	if( value < 5 ) {
#    	$("#paypalbox").attr('class', 'errorbox');
#//        $( ".warningbox" ).remove();
#//        $( ".errorbox" ).remove();
#//        $( "#amount" ).after( "<div class='errorbox' style='margin:10px 0;'><b>Attention&nbsp;:</b><br /> Si vous optez pour une cotisation libre, merci renseigner le champ \"Montant\" ci-dessus<br />La cotisation minimal est fixée à 5 euros.</div>" );
#        return false;
#        }
#    });
#});
