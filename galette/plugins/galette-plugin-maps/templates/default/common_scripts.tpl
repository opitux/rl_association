{if $GALETTE_MODE eq 'DEV'}
    {assign var=mainleaflet value="leaflet-1.2.0/leaflet-src.js" }
{else}
    {assign var=mainleaflet value="leaflet-1.2.0/leaflet.js" }
{/if}
<script type="text/javascript" src="{path_for name="plugin_res" data=["plugin" => $module_id, "path" => $mainleaflet]}"></script>
<script type="text/javascript" src="{path_for name="plugin_res" data=["plugin" => $module_id, "path" => "leaflet-control-osm-geocoder/Control.OSMGeocoder.js"]}"></script>
{if $cur_route eq 'maps_localize_member' or $cur_route eq 'maps_mymap'}
<script type="text/javascript" src="{path_for name="plugin_res" data=["plugin" => $module_id, "path" => "leaflet-locatecontrol/L.Control.Locate.min.js"]}"></script>
{/if}
<script type="text/javascript" src="{path_for name="plugin_res" data=["plugin" => $module_id, "path" => "leaflet-legendcontrol/L.Control.Legend.js"]}"></script>
<script type="text/javascript" src="{path_for name="plugin_res" data=["plugin" => $module_id, "path" => "leaflet-fullscreencontrol/Control.FullScreen.js"]}"></script>
<script type="text/javascript">

    /**
     * Returns element height, including margins
     */
    function _eltRealSize(_elt) {
        var _s = 0;
        _s += _elt.outerHeight();
        _s += parseFloat(_elt.css('margin-top').replace('px', ''));
        _s += parseFloat(_elt.css('margin-bottom').replace('px', ''));
        _s += parseFloat(_elt.css('padding-top').replace('px', ''));
        _s += parseFloat(_elt.css('padding-bottom').replace('px', ''));
        return _s;
    }

    /**
     * Rewrite maps height
     */
    function _hresize() {
        var wheight = $(window).height();
        var _oSize = 0;

        //récuperation de la taille des autres lignes
        $('#map').parents('section').siblings(':not(script)').each(function(){
            var _this = $(this);
            if ( !_this.hasClass('ui-dialog') ) {
                _oSize += _eltRealSize($(this));
            }
        });
        if ( $('#content').length > 0 ) {
            _oSize += _eltRealSize($('footer'));
            _oSize += parseFloat($('#content').css('padding-top').replace('px', ''));
            _oSize += parseFloat($('#content').css('padding-bottom').replace('px', ''));
        }

        //calcul et application de la nouvelle taille
        var newHeight = Math.floor(wheight - _oSize);
        var minHeight = 300;
        if ( newHeight < minHeight ) {
            newHeight = minHeight;
        }
        $("#map").css("height", newHeight + "px");
    }

    /**
     * Galette specific marker icon
     */
    var galetteIcon = L.icon({
        iconUrl: '{path_for name="plugin_res" data=["plugin" => $module_id, "path" => "leaflet-1.2.0/images/marker-galette.png"]}',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41]
    });
    var galetteProIcon = L.icon({
        iconUrl: '{path_for name="plugin_res" data=["plugin" => $module_id, "path" => "leaflet-1.2.0/images/marker-galette-pro.png"]}',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41]
    });

{if $cur_route neq 'maps_map'}
    function _iLiveHere(_id){
        $('#' + _id).click(function(e, f,g){
            var _a = $(this);
            var _latlng = _a.data('latlng');
            $.ajax({
                url: '{if isset($mymap)}{path_for name="maps_ilivehere"}{else}{path_for name="maps_ilivehere" data=[id => $member->id]}{/if}',
                type: 'POST',
                data: {
                    latitude: _latlng.lat,
                    longitude: _latlng.lng
                },
                {include file="js_loader.tpl"},
                success: function(res){
                    alert(res.message);
                    if (res.res == true) {
                        //not very pretty... but that works for the moment :)
                        window.location.reload();
                    }
                },
                error: function(){
                    alert("{_T string="An error occured during 'I live here' process :(" domain="maps" escape="js"}")
                }
            });
            return false;
        });
    }
{/if}

    $(function(){
        var _legendhtml = $('#legende').clone();
        _legendhtml.find('h1').remove()
        $('#legende').remove();

        _hresize();

        var _lat = {if isset($town)}{$town['latitude']}{else}46.830133640447386{/if};
        var _lon = {if isset($town)}{$town['longitude']}{else}2.4609375{/if};
        var map = L.map(
            'map', {
                fullscreenControl: true,
                fullscreenControlOptions: {
                    title: "{_T string="Display map in full screen" domain="maps"}",
                    forceSeparateButton:true
                }
            }
        ).setView([_lat, _lon], {if isset($town)}12{else}6{/if});

        var osmGeocoder = new L.Control.OSMGeocoder({
            collapsed: false,
{if $cur_route eq 'maps_localize_member' and !isset($town)}
            placeholder: '{_T string="Search your town..." domain="maps" escape="js"}',
{else}
            placeholder: '{_T string="Search a town..." domain="maps" escape="js"}',
{/if}
            text: '{_T string="Search" domain="maps" escape="js"}',
            callback: function (results) {
                if (results.length == 0) {
                    var _div = $('<div title="{_T string="No result found" domain="maps" escape="js"}">{_T string="Sorry, that town could not be found." domain="maps" escape="js"}</div>');
                    _div.dialog();
                    return;
                }

                // get coordinates for result
                var coords = L.latLng(results[0].lat,results[0].lon);

                // create a marker for result
                var marker = L.marker(coords);

                // add result object to map and zoom to
                this._map.addLayer(marker).setView(coords,9);
            }
        });
        map.addControl(osmGeocoder);

        L.control.legend({
            strings: {
                title: '{_T string="Show legend"}'
            }
        }).addTo(map);

        _legend = L.control({
            position: 'bottomright'
        });
        _legend.onAdd = function (map) {
            var div = L.DomUtil.create('div', 'info legend');
            div.innerHTML = _legendhtml.html();
            return div;
        }
        _legend.addTo(map);

{if $cur_route eq 'maps_localize_member'}
        L.control.locate({
            strings: {
                title: '{_T string="Show me where I am" domain="maps" escape="js"}',
                popup: 'SELECTPOPUP',
                outsideMapBoundsMsg: '{_T string="You seem located outside the boundaries of the map" domain="maps" escape="js"}'
            }
        }).addTo(map);
{/if}

        L.tileLayer('http://{ldelim}s{rdelim}.basemaps.cartocdn.com/light_all/{ldelim}z{rdelim}/{ldelim}x{rdelim}/{ldelim}y{rdelim}.png', {
            maxZoom: 18,
            attribution: '{_T string="Map data ©" domain="maps" escape="js"} <a href="http://openstreetmap.org">{_T string="OpenStreetMap contributors" domain="maps" escape="js"}</a>, {_T string="Imagery ©" domain="maps" escape="js"} <a href="https://cartodb.com/attributions">CartoDB</a>'
        }).addTo(map);

        try {
            _mapsBinded(map);
        } catch (err) {
            //fortunately, nothing to do here.
            //_mapsBinded function can be missing
        }
    });
</script>

