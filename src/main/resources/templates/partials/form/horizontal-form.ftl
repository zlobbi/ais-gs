<#import "/spring.ftl" as spring>

<#macro label path required=false>
<label class="control-label col-sm-4">
    <@spring.message path/>:
    <#if required><span style="color:red">*</span></#if></label>
</#macro>

<#macro inputText path fieldType="text" required=false class="" attributes="" allowed=true >
    <div class="form-group">
        <@spring.bind path />
        <#assign attributesOverride = attributes + required?string(" required","")/>
        <@label path required/>
        <div class="col-sm-8">
            <@spring.formInput path 'class="form-control'+(class??)?then(" "+class,"")+'" '+attributesOverride fieldType/>
                    <@spring.showErrors "<br>" "text-danger" />
        </div>
    </div>
</#macro>

<#macro inputDateTime path required=false offset=0>
<div class="form-group">
    <@spring.bind path />
    <#assign replacedPath = path?replace(".", "-") />
    <#assign dateId = "anytime-month-numeric-${replacedPath}" />
    <@label path required />
    <div class="col-sm-8">
        <div class="input-group">
            <span class="input-group-addon"><i class="icon-calendar3"></i></span>
            <input type="text" name="${spring.status.expression}"
                   class="form-control anytime-both" ${required?string("required","")}
                   id="${dateId}"
                   <#if spring.stringStatusValue?? && spring.stringStatusValue?has_content>value="${spring.stringStatusValue?string}"</#if>
                   placeholder="${springMacroRequestContext.getMessage(path)}">
        </div>
        <@spring.showErrors "<br>" "text-danger" />
    </div>
</div>
<script>
    $("#${dateId}").AnyTime_picker({
        format: "%d.%m.%Z %H:%i",
        firstDOW: 1,
        beforeShow: function () {
            setTimeout(function () {
                $('.ui-datepicker').css('z-index', 99999999999999);
            }, 0);
        }
    });

    if (0 != ${offset}) {
        var d8 = new Date();
        d8.setHours(d8.getHours() + ${offset});
        $('#${dateId}').val(new AnyTime.Converter({format: "%d.%m.%Z %H:%i"}).format(d8));
    }
</script>
</#macro>

<#macro select2 path url selected attributes="" required=false placeholder="" multiple=false allowClear=true>
    <@spring.bind path/>
    <#assign replacedPath = path?replace(".", "-") />
    <#assign selectId = "select-id-${replacedPath}" />
    <#assign varId = path?replace(".", "") />
<div class="form-group">
    <@label path required/>
    <div class="col-sm-8">
        <select id="${selectId}" ${multiple?then("multiple","")}
                name="${spring.status.expression}" ${required?then("required","")} ${attributes}>
            <#if selected?? && selected?has_content>
                <option value="${selected.getSelectorId()}"
                        selected="selected">${selected.getSelectorTitle()}</option>
            </#if>
        </select>
        <@spring.showErrors "<br>" "text-danger" />
    </div>
</div>

<script type="application/javascript">
    var select2${varId} = "${url}";
    $(function () {
        $("#${selectId}").select2({
            width: "100%",
            ajax: {
                url: function () {
                    console.log(select2${varId});
                    return select2${varId};
                },
                dataType: 'json',
                delay: 250,
                data: function (params) {
                    return {
                        q: params.term, // search term
                        page: isNaN(params.page) ? 0 : params.page - 1
                    };
                },
                processResults: function (data, params) {
                    return {
                        results: data._embedded ? data._embedded.list : [],
                        pagination: {
                            more: ((data.page.number + 1) * data.page.size) < data.page.totalElements
                        }
                    };
                },
                cache: true
            },
            placeholder: "<@spring.message placeholder />",
            allowClear: ${allowClear?c},
            templateSelection: function (data) {

                return data.selectorTitle || data.title || data.text;
            },
            templateResult: function (data, container) {
                if (data.className != null)
                    $(container).addClass(data.className);
                return data.selectorTitle || data.title;
            }
        });
    });
</script>
</#macro>

<#macro select2Multiple path url selected required=false showLabel=true>
    <@spring.bind path/>
    <#assign replacedPath = path?replace(".", "-") />
    <#assign selectId = "select-id-${replacedPath}" />

<div class="form-group">
    <#if showLabel><@label path required/></#if>
    <div class="col-sm-8">
        <select id="${selectId}" multiple="multiple"
                name="${spring.status.expression}" ${required?then("required","")}>
            <#if selected?? && selected?has_content>
                <#if selected?is_enumerable>
                    <#list selected as selectedItem>
                        <option value="${selectedItem.getSelectorId()}"
                                selected="selected">${selectedItem.getSelectorTitle()}</option>
                    </#list>
                <#else>
                    <option value="${selected.getSelectorId()}"
                            selected="selected">${selected.getSelectorTitle()}</option>
                </#if>
            </#if>
        </select>
        <@spring.showErrors "<br>" "text-danger" />
    </div>
</div>

<script type="application/javascript">
    $(function () {
        $("#${selectId}").select2({
            width: "100%",
            ajax: {
                url: "${url}",
                dataType: 'json',
                delay: 250,
                data: function (params) {
                    return {
                        q: params.term,
                        page: params.page == null ? 0 : params.page - 1
                    };
                },
                processResults: function (data, params) {
                    return {
                        results: data._embedded ? data._embedded.list : [],
                        pagination: {
                            more: ((data.page.number + 1) * data.page.size) < data.page.totalElements
                        }
                    };
                },
                cache: true
            },
            templateSelection: function (data) {
                console.log(data);
                return data.selectorTitle || data.title || data.text;
            },
            templateResult: function (data) {
                console.log(data);
                return data.selectorTitle || data.title;
            }
        });
    });
</script>
</#macro>

<#macro print path title="" icon="icon-pencil" showSubmit=true lastUpdatedAt="">
    <@noSubmitPrintFile path>
        <div class="card card-custom">
            <div class="card-header">
                <h5 class="card-text">
                    <i class="${icon}"></i>
                    <@spring.message title />
                </h5>
            </div>
            <div class="card-body">
                <#nested />
            </div>
            <#if showSubmit>
                <div class="card-footer text-end">
                    <input type="hidden" name="lastUpdatedAt" value="${lastUpdatedAt}" />
                    <@inputSubmit />
                </div>
            </#if>
        </div>
    </@noSubmitPrintFile>
</#macro>

<#macro noSubmitPrintFile path>
    <form class="form-horizontal form"
          action="${path}"
          method="POST"
          role="form"
          enctype="multipart/form-data">
        <#nested />
    </form>
</#macro>

<#macro inputSubmit text="action.accept" class="primary" id="">
    <button <#if (id?has_content)>id="${id}"</#if> type="submit" class="btn btn-${class}">
        <@spring.message text />
    </button>
</#macro>

<#macro textArea path required=false attributes="">
    <@spring.bind path />
    <#assign attr = attributes?string + " rows='5' cols='5' class='elastic form-control' style='overflow: hidden; word-wrap: break-word; resize: vertical; height: 160px;'"/>
    <div class="form-group">
        <@label path required/>
        <div class="col-sm-8">
            <@spring.formTextarea path attr />
        </div>
    </div>
</#macro>

<#macro checkBox path required=false checked=false>
    <div class="form-group<#if required> required</#if>">
        <@spring.bind path />
        <@label path required/>
        <div class="col-sm-8">
            <@spring.formCheckbox path 'class="styled" ${checked?then("checked","")}'/>
        </div>
        <@spring.showErrors "<br>" "text-danger" />
    </div>
</#macro>


<#macro inputColor path required=false>
    <div class="form-group">
        <@spring.bind path />
        <@label path required/>
        <div class="col-sm-8">
            <@spring.formInput path ' class="form-control color-picker" data-preferred-format="hex" ' "text"/>
            <@spring.showErrors "<br>" "text-danger" />
        </div>
    </div>
    <script type="text/javascript">
        $(".color-picker").spectrum({
            showInput: true
        });
    </script>
</#macro>