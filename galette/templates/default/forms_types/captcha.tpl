{extends file="forms_types/input.tpl"}

{block name="component"}
    {assign var="type" value="password"}
    {assign var="value" value=null}
    {$smarty.block.parent}
{/block}

{block name="label"}
    {$smarty.block.parent}
    <input type="hidden" name="mdp_crypt" value="{$spam_pass}" />
    <img src="{$spam_img}" alt="{_T string="Password image"}" class="mdp_img" />
{/block}
