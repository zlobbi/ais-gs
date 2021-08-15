<#assign security = JspTaglibs["http://www.springframework.org/security/tags"] />

<#macro access v="true">
    <@security.authorize access=v>
        <#nested>
    </@security.authorize>
</#macro>
