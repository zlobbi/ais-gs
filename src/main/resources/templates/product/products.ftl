<#import "/spring.ftl" as spring />
<#import "../layout/main.ftl" as main />
<#import "../partials/table.ftlh" as table />

<#assign arr = {"/product" : 'products'} />

<@main.render arr arr>
    <div class="row">
        <div class="col-md-8">
            <@table.render products true />
        </div>
    </div>
</@main.render>