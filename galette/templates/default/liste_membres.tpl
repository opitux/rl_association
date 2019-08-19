{extends file="public_page.tpl"}
{block name="content"}
{if $members|@count > 0}
{* BEGIN MODIF OPITUX *}
{* Bloc supprimé text indiquant que l'on peut masquer son profil dans ses préférences *}

{* END MODIF OPITUX *}
        <form action="{path_for name="filterPublicMemberslist"}" method="POST" id="filtre">
        <table class="infoline">
            <tr>
                <td class="left">{$nb_members} {if $nb_members != 1}{_T string="members"}{else}{_T string="member"}{/if}</td>
                <td class="right">
                    <label for="nbshow">{_T string="Records per page:"}</label>
                    <select name="nbshow" id="nbshow">
                        {html_options options=$nbshow_options selected=$numrows}
                    </select>
                    <noscript> <span><input type="submit" value="{_T string="Change"}" /></span></noscript>
                </td>
            </tr>
        </table>
        </form>
        <table class="listing">
            <thead>

                <tr>
					{* BEGIN MODIF OPITUX *}
					{* Bloc supprimé Nom/prénom *}

					{* END MODIF OPITUX *}
                    <th class="left">
                        <a href="{path_for name="publicMembers" data=["option" => {_T string="order" domain="routes"}, "value" => {Galette\Repository\Members::ORDERBY_NICKNAME}]}" class="listing">
                            {_T string="Nickname"}
                            {if $filters->orderby eq constant('Galette\Repository\Members::ORDERBY_NICKNAME')}
                                {if $filters->ordered eq constant('Galette\Filters\MembersList::ORDER_ASC')}
                            <img src="{base_url}/{$template_subdir}images/down.png" width="10" height="6" alt=""/>
                                {else}
                            <img src="{base_url}/{$template_subdir}images/up.png" width="10" height="6" alt=""/>
                                {/if}
                            {/if}
                        </a>
                    </th>
                    {if $login->isLogged()}
                    <th class="left">
{* BEGIN MODIF OPITUX *}
{* Ajout de l'id pour tous et du mail si staff logged *}
                        {_T string="id"}
                    {if $login->isAdmin() or $login->isStaff()} /
                        {_T string="Email"}
                    {/if}
{* END MODIF OPITUX *}
                    </th>
                    {/if}
                    <th class="left">
                        {_T string="Informations"}
                    </th>
{* BEGIN MODIF OPITUX *}
{* Ajout de la colonne Informations Asso si staff logged *}
                    {if $login->isAdmin() or $login->isStaff()}
                    <th class="left">
                        {_T string="Informations Asso"}
                    </th>
                    {/if}
{* END MODIF OPITUX *}
                </tr>
            </thead>
            <tbody>
    {foreach from=$members item=member name=allmembers}
                <tr class="{if $smarty.foreach.allmembers.iteration % 2 eq 0}even{else}odd{/if}">
{* BEGIN MODIF OPITUX *}
{* Bloc Nom/prénom supprimé *}

{* END MODIF OPITUX *}
                    <td class="{$member->getRowClass(true)} nowrap" data-title="{_T string="Nickname"}">{$member->nickname|htmlspecialchars}</td>
                    <td class="{$member->getRowClass(true)} nowrap" data-title="{_T string="Email"}">
{* BEGIN MODIF OPITUX *}
{* Ajout de l'id pour tous et du mail si staff logged *}
                        {$member->id}
                    {if $login->isAdmin() or $login->isStaff()}
                         / <a href="mailto:{$member->email}">{$member->email}</a></td>
                    {/if}
{* END MODIF OPITUX *}
                    </td>
                    <td class="{$member->getRowClass(true)} nowrap" data-title="{_T string="Informations"}">{$member->others_infos}</td>
{* BEGIN MODIF OPITUX *}
{* Ajout de la colonne Informations Asso si staff logged *}
                    {if $login->isAdmin() or $login->isStaff()}
                    <td class="{$member->getRowClass(true)} nowrap" data-title="{_T string="Informations"}">{$member->others_infos_admin}</td>
                    {/if}
{* END MODIF OPITUX *}
                </tr>
    {/foreach}
            </tbody>
        </table>
        <div class="center cright">
            {_T string="Pages:"}<br/>
            <ul class="pages">{$pagination}</ul>
        </div>
{else}
    <div id="infobox">{_T string="No member to show"}</div>
{/if}
{/block}

{block name="javascripts"}
    {if $members|@count > 0}
        <script type="text/javascript">
            $(function(){
                $('#nbshow').change(function() {
                    this.form.submit();
                });
            });
        </script>
    {/if}
{/block}
