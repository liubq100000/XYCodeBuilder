/**
* jquery.validate
*/
<#noparse> $("#entityForm").validate({</#noparse>
    ignore:'ignore',
    rules: {
    <#list attrs as attr>
        <#if (attr.busiItemType>0)>
        ${attr.camelName}: { required: false, maxlength:${attr.size?c} },
        </#if>
    </#list>
    }
});