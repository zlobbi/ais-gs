<#import "/spring.ftl" as spring>
<#import "horizontal-form.ftl" as hor_form/>

<#macro label path required=false>
    <#assign replacedPath = path?replace("\\[\\d\\]", "[]", "r") />

    <label class="form-label">
        ${springMacroRequestContext.getMessage(replacedPath)}: ${required?then("<span style='color:red'>*</span>","")}
    </label>
</#macro>

<#macro checkLabel path required=false>
    <#assign replacedPath = path?replace("\\[\\d\\]", "[]", "r") />

    <label class="form-check-label">
        ${springMacroRequestContext.getMessage(replacedPath)} ${required?then("<span style='color:red'>*</span>","")}
    </label>
</#macro>

<#macro inputText path fieldType="text" required=false class="" attributes="">
    <#assign replacedPath = path?replace("\\[\\d\\]", "[]", "r") />
    <#assign attributesOverride = attributes + required?string(" required","") />
    <#assign attributesOverride = attributesOverride + ' placeholder="${springMacroRequestContext.getMessage(replacedPath)}"' />


    <div class="mb-3<#if required> required</#if>">
        <@label path required />

        <@spring.bind path />
        <@spring.formInput path 'class="form-control' + (class??)?then(" " + class,"") + '" ' + attributesOverride fieldType />
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${spring.status.expression}-error" class="error" for="${spring.status.expression}"
               style="display: none;"></label>
    </div>
</#macro>

<#macro inputTextWithBtn path fieldType="text" required=false class="" attributes="" btnId="" btnText="">
    <#assign replacedPath = path?replace("\\[\\d\\]", "[]", "r") />
    <#assign attributesOverride = attributes + required?string(" required","") />
    <#assign attributesOverride = attributesOverride + ' placeholder="${springMacroRequestContext.getMessage(replacedPath)}"' />

    <div class="mb-3<#if required> required</#if>">
        <@label path required />

        <div class="input-group">
            <@spring.bind path />
            <@spring.formInput path 'class="form-control' + (class??)?then(" " + class,"") + '" ' + attributesOverride fieldType />
            <button class="btn btn-outline-secondary" type="button" id="${btnId}">
                ${springMacroRequestContext.getMessage(btnText)}
            </button>
        </div>
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${spring.status.expression}-error" class="error" for="${spring.status.expression}"
               style="display: none;"></label>
    </div>
</#macro>

<#macro checkBox path required=false switch=false>
    <#assign replacedPath = path?replace("\\[\\d\\]", "[]", "r") />
    <#assign class = required?string(" required","") + switch?string(" form-switch","") />

    <div class="form-check${class}">
        <@spring.bind path />
        <@spring.formCheckbox path 'class="form-check-input" ${required?then("required","")}' />
        <@checkLabel path required />
        <div style="margin-left: -2.25rem;">
            <@spring.showErrors "<br>" "form-text text-danger spring-error" />
            <label id="${spring.status.expression}-error" class="error" for="${spring.status.expression}"
                   style="display: none;"></label>
        </div>
    </div>
</#macro>

<#macro select2 path url selected attributes="" required=false allowClear=true info=false>
    <#assign replacedPath = path?replace(".", "-") />
    <#assign replacedPath = replacedPath?replace("[", "") />
    <#assign replacedPath = replacedPath?replace("]", "") />
    <#assign placeholderPath = path?replace("\\[\\d\\]", "[]", "r") />
    <#assign selectId = "select-id-${replacedPath}" />
    <#assign varId = path?replace(".", "")?replace("[", "")?replace("]", "") />

    <div class="mb-3">
        <@label path required />

        <@spring.bind path />
        <select id="${selectId}" name="${spring.status.expression}" ${attributes} ${required?then("required","")}>
            <#if selected?? && selected?has_content>
                <option value="${selected.getSelectorId()}" selected="selected">
                    ${selected.getSelectorTitle()}
                </option>
            </#if>
        </select>
        <#if info>
            <div class="form-text">
                ${springMacroRequestContext.getMessage(placeholderPath + "Info")}
            </div>
        </#if>
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${selectId}-error" class="error" for="${selectId}" style="display: none;"></label>
    </div>

    <script type="application/javascript">
        let select2${varId} = "${url}";

        $(function () {
            $("#${selectId}").select2({
                width: "100%",
                placeholder: "<@spring.message placeholderPath />",
                allowClear: ${allowClear?c},
                ajax: {
                    url: function () {
                        return select2${varId};
                    },
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term,
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

<#macro select2Multiple path url selected required=false attributes="">
    <#assign replacedPath = path?replace(".", "-") />
    <#assign selectId = "select-id-${replacedPath}" />

    <div class="mb-3">
        <@label path required/>

        <@spring.bind path/>
        <select id="${selectId}" multiple="multiple"
                name="${spring.status.expression}" ${required?then("required","")} ${attributes}>
            <#if selected?has_content>
                <#if selected?is_enumerable>
                    <#list selected as selectedItem>
                        <option value="${selectedItem.getSelectorId()}" selected="selected">
                            ${selectedItem.getSelectorTitle()}
                        </option>
                    </#list>
                <#else>
                    <option value="${selected.getSelectorId()}" selected="selected">
                        ${selected.getSelectorTitle()}
                    </option>
                </#if>
            </#if>
        </select>
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${selectId}-error" class="error" for="${selectId}" style="display: none;"></label>
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
                templateSelection: function (data) {
                    return data.title || data.text;
                },
                templateResult: function (data) {
                    return data.title;
                }
            });
        });
    </script>
</#macro>

<#macro inputDate path required=false attributes="">
    <#assign replacedPath = path?replace(".", "-") />
    <#assign dateId = "anytime-month-numeric-${replacedPath}" />

    <div class="mb-3">
        <@label path required />

        <@spring.bind path />
        <div class="input-group">
            <button class="btn btn-outline-secondary" type="button" id="${dateId}-button">
                <i class="icon-calendar3"></i>
            </button>

            <input type="text" name="${spring.status.expression}" ${required?string("required","")} id="${dateId}"
                   class="form-control"
                    <#if spring.stringStatusValue?? && spring.stringStatusValue?has_content>value="${spring.stringStatusValue?string}"</#if>
                   placeholder="${springMacroRequestContext.getMessage(path)}" ${attributes}>

            <button class="btn btn-outline-secondary" type="button" id="${dateId}-clear">
                <i class="icon-close2"></i>
            </button>
        </div>
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${spring.status.expression}-error" class="error" for="${spring.status.expression}"
               style="display: none;"></label>
    </div>

    <script>
        $("#${dateId}-button").click(function () {
            $("#${dateId}")
                .AnyTime_noPicker()
                .AnyTime_picker({
                    labelTitle: "Выберите дату",
                    labelYear: "Год",
                    labelMonth: "Месяц",
                    labelDayOfMonth: "День",
                    dayNames: ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"],
                    dayAbbreviations: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
                    monthAbbreviations: ["Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек"],
                    monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"],
                    format: "%d.%m.%Z",
                    firstDOW: 1,
                    beforeShow: function () {
                        setTimeout(function () {
                            $('.ui-datepicker').css('z-index', 99999999999999);
                        }, 0);
                    }
                })
                .focus();
        });

        $("#${dateId}-clear").click(function () {
            $("#${dateId}").AnyTime_noPicker();
            $("#${dateId}").val("").change();
        });
    </script>
</#macro>

<#macro textArea path required=false attributes="" info=false>
    <#assign attributesOverride = attributes + ' rows="5" cols="5" class="elastic form-control" style="overflow: scroll; word-wrap: break-word; resize: vertical; height: 80px;"' />
    <#assign attributesOverride = attributesOverride + required?string(" required","") />
    <#assign attributesOverride = attributesOverride + ' placeholder="${springMacroRequestContext.getMessage(path)}"' />

    <div class="mb-3">
        <@label path required />

        <@spring.bind path />
        <@spring.formTextarea path attributesOverride />
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${spring.status.expression}-error" class="error" for="${spring.status.expression}"
               style="display: none;"></label>
    </div>
</#macro>

<#macro select2list path options value="" nullValue=false multiple=false attributes="">
    <#assign replacedPath = path?replace(".", "-") />
    <#assign selectId = "select-id-${replacedPath}" />

    <div class="mb-3">
        <@label path />

        <@spring.bind path/>
        <select id="${selectId}" ${multiple?then("multiple","")} name="${spring.status.expression}" ${attributes}>
            <#list options as option>
                <#if nullValue>
                    <option></option>
                </#if>
                <#assign selected = value?has_content && value.getSelectorId() == option.getSelectorId()>
                <option value="${option.getSelectorId()}" ${selected?then('selected="selected"','')}>
                    ${option.getSelectorTitle()}
                </option>
            </#list>
        </select>
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${spring.status.expression}-error" class="error" for="${spring.status.expression}"
               style="display: none;"></label>
    </div>

    <script type="application/javascript">
        $("#${selectId}").select2({
            width: "100%",
            minimumResultsForSearch: Infinity,
            <#if nullValue>
            placeholder: "",
            allowClear: true
            </#if>
        });
    </script>
</#macro>

<#macro inputDateTime path required=false attributes="">
    <#assign replacedPath = path?replace(".", "-") />
    <#assign dateId = "anytime-month-numeric-${replacedPath}" />

    <div class="mb-3">
        <@label path required />

        <@spring.bind path />
        <div class="input-group">
            <button class="btn btn-outline-secondary" type="button" id="${dateId}-button">
                <i class="icon-calendar3"></i>
            </button>

            <input type="text" name="${spring.status.expression}" ${required?string("required","")} id="${dateId}"
                   class="form-control"
                    <#if spring.stringStatusValue?? && spring.stringStatusValue?has_content>value="${spring.stringStatusValue?string}"</#if>
                   placeholder="${springMacroRequestContext.getMessage(path)}" ${attributes}>

            <button class="btn btn-outline-secondary" type="button" id="${dateId}-clear">
                <i class="icon-close2"></i>
            </button>
        </div>
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${dateId}-error" class="error" for="${dateId}" style="display: none;"></label>
    </div>

    <script>
        $("#${dateId}").focusin(function () {
        });

        $("#${dateId}-button").click(function () {
            $("#${dateId}")
                .AnyTime_noPicker()
                .AnyTime_picker({
                    labelTitle: "Выберите дату/время",
                    labelYear: "Год",
                    labelMonth: "Месяц",
                    labelDayOfMonth: "День",
                    labelHour: "Часы",
                    labelMinute: "Минуты",
                    labelSecond: "Секунды",
                    dayNames: ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"],
                    dayAbbreviations: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
                    monthAbbreviations: ["Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек"],
                    monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"],
                    format: "%d.%m.%Z %H:%i",
                    firstDOW: 1,
                    beforeShow: function () {
                        setTimeout(function () {
                            $('.ui-datepicker').css('z-index', 99999999999999);
                        }, 0);
                    }
                })
                .focus();
        });

        $("#${dateId}-clear").click(function () {
            $("#${dateId}").AnyTime_noPicker();
            $("#${dateId}").val("").change();
        });
    </script>
</#macro>

<#macro select2listExpanded path options selected required=false attribute="">
    <#assign replacedPath = path?replace(".", "-") />
    <#assign selectId = "select-expanded-id-${replacedPath}" />
    <div class="mb-3">
        <@label path required />

        <@spring.bind path />
        <select id="${selectId}" ${required?then("required","")} name="${spring.status.expression}" ${attribute}
                class="form-control">
            <#if options?? && options?has_content>
                <#list options as option>
                    <option value="${option.getSelectorId()}"
                            <#if selected?? && selected?has_content && selected.getSelectorId() == option.getSelectorId()>selected</#if>>
                        ${option.getSelectorTitle()}
                    </option>
                </#list>
            </#if>
        </select>
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${spring.status.expression}-error" class="error" for="${spring.status.expression}"
               style="display: none;"></label>
    </div>
</#macro>

<#macro inputTextWithButton path btnTitle fieldType="text" required=false class="" attributes="">
    <#assign btnPath = path?replace(".", "-") + "-btn" />
    <#assign attributesOverride = attributes + required?string(" required ","")/>
    <#assign attributesOverride = attributesOverride + ' placeholder="${springMacroRequestContext.getMessage(path)}" '/>

    <div class="mb-3<#if required> required</#if>">
        <@label path required />

        <@spring.bind path />
        <div class="input-group">
            <@spring.formInput path 'class="form-control'+(class??)?then(" "+class,"")+'" '+attributesOverride fieldType />
            <button class="btn btn-outline-secondary ${btnPath}" type="button" id="${btnPath}">
                ${btnTitle}
            </button>
        </div>
        <@spring.showErrors "<br>" "form-text text-danger spring-error" />
        <label id="${spring.status.expression}-error" class="error" for="${spring.status.expression}"
               style="display: none;"></label>
    </div>
</#macro>

<#macro hiddenField path>
    <@spring.formHiddenInput path />
</#macro>
<#-- Проверено до этого места -->

<#macro inputTextWithTooltip path fieldType="text" required=false class="" attributes=" " allowed=true >
    <#assign replacedPath = path?replace("\\[\\d\\]", "[]", "r") />
    <div class="form-group<#if required> required</#if>">
        <@spring.bind path />
        <#assign attributesOverride = attributes + required?string(" required ","")/>
        <#assign attributesOverride = attributesOverride + ' placeholder="${springMacroRequestContext.getMessage(replacedPath)}" '/>
        <#assign attributesOverride = attributesOverride + ' data-popup="tooltip" data-trigger="focus" data-original-title="${springMacroRequestContext.getMessage(replacedPath + ".tooltip")}" '/>
        <@label path required/>
        <@spring.formInput path 'class="form-control'+(class??)?then(" "+class,"")+'" '+attributesOverride fieldType/>
        <@spring.showErrors "<br>" "text-danger" />
    </div>
</#macro>

<#macro fileInput path required=false attributes="">
    <#assign replacedPath = path?replace("[\\d]", "[]") />
    <#assign replacedId = path?replace("[", "") />
    <#assign replacedId = replacedId?replace("]", "") />
    <#assign replacedId = replacedId?replace(".", "-") />

    <div class="mb-3">
        <@label path required/>
        <input id="${replacedId}" name="${replacedPath}" type="file" class="form-control" ${attributes} />
    </div>

    <script>
        $('input[type=file]').bind('change', function () {
            if ($(this).val().indexOf("..") > 0) {
                Swal.fire({
                    title: "<@spring.message "error.title"/>",
                    text: "<@spring.message "error.file-not-contain-double-dot"/>",
                    type: "error"
                });
                $(this).val('');
            } else {
                var sizeOfFiles = 0;
                var inputFiles = $("form :input[type=file]");
                for (var key in inputFiles) {
                    if (inputFiles[key].files && inputFiles[key].files[0]) {
                        sizeOfFiles += inputFiles[key].files[0].size;
                    }
                }
                if (sizeOfFiles > maxFileSizeInBytes) {
                    Swal.fire({
                        title: "<@spring.message "error.title"/>",
                        text: "<@spring.message "error.file-more-than-required"/>",
                        type: "error"
                    });
                    $(this).val('');
                }
            }
        });
    </script>
</#macro>

<#macro fileInputBind path required=false fileMask="">
    <@spring.bind path/>
    <div class="form-group">
        <@label path required/>
        <#assign replacedPath = path?replace(".", "-") />
        <#assign fileInputId = "${replacedPath}" />
        <div class="col-md-12">
            <input id="${fileInputId}" name="${spring.status.expression}" type="file" class="file-styled"
                   accept="${fileMask}">
            <@spring.showErrors "<br>" "text-danger" />
        </div>
    </div>
    <script>
        $('#${fileInputId}').bind('change', function () {
            if ($(this).val().indexOf("..") > 0) {
                swal({
                    title: "<@spring.message "error.title"/>",
                    text: "<@spring.message "error.file-not-contain-double-dot"/>",
                    type: "error"
                });
                $(this).val('');
            } else {
                var fileSize;
                var sizeOfFiles = 0;
                var inputFiles = $("form :input[type=file]");
                for (var item: inputFiles) {
                    if (item.files && item.files[0]) {
                        fileSize = item.files[0].size;
                        sizeOfFiles = sizeOfFiles + fileSize;
                    }
                }
                if (sizeOfFiles > maxFileSizeInBytes) {
                    swal({
                        title: "<@spring.message "error.title"/>",
                        text: "<@spring.message "error.file-more-than-required"/>",
                        type: "error"
                    });
                    $('#${fileInputId}').val('');
                }
            }
        });

        $('.file-styled').uniform({
            fileButtonClass: 'action btn bg-blue',
            fileDefaultHtml: "<@spring.message 'input.noFile'/>",
            fileButtonHtml: "<@spring.message 'input.chooseFile'/>"
        });
    </script>
</#macro>

<#macro select2WithoutBinding path url selected attributes="" required=false allowClear=false placeholder="">
    <#assign replacedPath = path?replace(".", "-")?replace("[", "")?replace("]", "") />
    <#assign placeholderPath = path?replace("\\[\\d\\]", "[]", "r") />
    <#assign selectId = "select-id-${replacedPath}" />
    <#assign varId = path?replace(".", "")?replace("[", "")?replace("]", "") />
    <div class="">
        <@label path required/>
        <div class="">
            <select id="${selectId}" ${attributes} ${required?then("required","")}>
                <#if selected?? && selected?has_content>
                    <option value="${selected.getSelectorId()}"
                            selected="selected">${selected.getSelectorTitle()}</option>
                </#if>
            </select>
        </div>
    </div>

    <script type="application/javascript">
        var select2${varId} = "${url}";
        $(function () {
            $("#${selectId}").select2({
                width: "100%",
                placeholder: "<@spring.message placeholderPath />",
                allowClear: ${allowClear?c},
                ajax: {
                    url: function () {
                        return select2${varId};
                    },
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term
                            page: params.page
                        };
                    },
                    processResults: function (data, params) {
                        console.log("processResults", data);
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

<#macro printUpdateControl path title="" lastUpdatedAt="">
    <@print path title "icon-pencil" true lastUpdatedAt>
        <#nested />
        <@correctionActionDate />
    </@print>
</#macro>

<#macro print path title="" icon="icon-pencil" showSubmit=true lastUpdatedAt="">
    <@noSubmitPrint path>
        <div class="card card-custom">
                <div class="card-header">
                <h5 class="card-text">
                    <i class="${icon}"></i>
                    <@spring.message title />
                </h5>
            </div>
            <div class="card-body">
                <#nested />
                <input type="hidden" name="lastUpdatedAt" value="${lastUpdatedAt}"/>
            </div>
            <#if showSubmit>
                <div class="card-footer text-end">
                    <@inputSubmit />
                    <@inputCancel />
                </div>
            </#if>
        </div>
        <@singleSubmitScript/>
    </@noSubmitPrint>
</#macro>

<#macro correctionActionDate>
    <#if erpp?has_content && erpp.currentCorrection?has_content && erpp.currentCorrection.createdBy.id=user.id>
        <#assign lastActionDate = erpp.actionDate!erpp.updatedAt />
    <#elseif erppSuspect?has_content && erppSuspect.currentCorrection?has_content && erppSuspect.currentCorrection.createdBy.id=user.id>
        <#assign lastActionDate = erppSuspect.actionDate!erppSuspect.updatedAt />
    <#elseif domainActionDate?has_content>
        <#assign lastActionDate = domainActionDate />
    </#if>
    <#if lastActionDate?has_content>
        <div class="action-date-group">
            <div class="form-group">
                <#assign dateId = "anytime-month-numeric-actionDate" />
                <label class="control-label">Дата принятия решения <span style="color:red">*</span> : </label>
                <div class="input-group">
                    <span id="${dateId}-button"
                          class="input-group-addon">
                        <i class="icon-calendar3"></i>
                    </span>
                    <input type="text" name="actionDate" id="${dateId}" class="form-control anytime-both" required/>
                    <span id="${dateId}-clear" class="input-group-addon"><i class="icon-close2"></i></span>
                </div>
            </div>
            <script>
                $("#${dateId}").mask('00.00.0000 00:00', {placeholder: "__.__.____ __:__"});
                $("#${dateId}-button").click(function () {
                    $("#${dateId}")
                        .AnyTime_noPicker()
                        .AnyTime_picker({
                            labelTitle: "Выберите дату/время",
                            labelYear: "Год",
                            labelMonth: "Месяц",
                            labelDayOfMonth: "День",
                            labelHour: "Часы",
                            labelMinute: "Минуты",
                            labelSecond: "Секунды",
                            dayNames: ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"],
                            dayAbbreviations: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
                            monthAbbreviations: ["Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек"],
                            monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"],
                            format: "%d.%m.%Z %H:%i",
                            firstDOW: 1,
                            beforeShow: function () {
                                setTimeout(function () {
                                    $('.ui-datepicker').css('z-index', 99999999999999);
                                }, 0);
                            }
                        })
                        .focus();
                });

                $("#${dateId}-clear").click(function () {
                    $("#${dateId}").AnyTime_noPicker();
                    $("#${dateId}").val("").change();
                });
            </script>
        </div>
    </#if>
</#macro>

<#macro singleSubmitScript>
    <script>
        $(function () {
            let $form = $("form");
            let requestSent = false;
            $("button[type=submit]").click(function (e) {
                if ($form.valid() && !requestSent) {
                    requestSent = true;
                    $(this).attr("disabled", true);
                    $form.submit();
                }
            });
        });
    </script>
</#macro>

<#macro pdfPreviewScript>
    <script type="text/javascript" src="/assets/js/plugins/pdf/pdfobject.min.js"></script>
    <script>
        $(function () {
            let $form = $("form");

            let requestSent = false;
            $("#submit").click(function (e) {
                if ($form.valid() && !requestSent) {
                    requestSent = true;
                    $(this).attr("disabled", true);
                    $form.submit();
                }
            });

            $("button[type=submit]").unbind("click").bind("click", function (e) {
                e.preventDefault();
                if ($form.valid()) {
                    var formData = new FormData(jQuery('form')[0]);
                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', window.location.href.replace('?', '-preview?'), true);
                    xhr.responseType = "blob";
                    xhr.onload = function () {
                        var fileURL = URL.createObjectURL(xhr.response);
                        PDFObject.embed(fileURL, "#embed");
                        $("#modal_preview").modal('show');
                    };
                    xhr.send(formData);
                }
            });
        });
    </script>
    <div id="modal_preview" class="modal fade">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h5 class="modal-title">Предварительный просмотр</h5>
                </div>

                <div class="modal-body">
                    <div id="embed" style="height: 700px"></div>
                </div>

                <div class="modal-footer">
                    <button id="submit" type="button" class="btn btn-primary">Отправить</button>
                    <button type="button" class="btn btn-link" data-dismiss="modal">Закрыть</button>
                </div>
            </div>
        </div>
    </div>
</#macro>

<#macro noSubmitPrint path>
    <form class="form" action="${path}" role="form" method="POST" enctype="multipart/form-data">
        <#nested />
    </form>
</#macro>

<#macro inputSubmit text="action.accept" class="primary">
    <button type="submit" class="btn btn-${class}"><@spring.message text /></button>
</#macro>

<#macro inputCancel text="action.cancel" class="default" class="violet">
    <button type="button" onclick="history.back()" class="btn btn-${class}"><@spring.message text /></button>
</#macro>

<#macro textAreaCustomPlaceholder path placeholder required=false attributes="" info=false>
    <@spring.bind path />
    <div class="form-group">
        <@label path required info/>
        <div class="">
            <#assign attributesOverride = attributes + ' rows="5" cols="5" class="elastic form-control" style="overflow: scroll; word-wrap: break-word; resize: vertical; height: 80px;"'/>
            <#assign attributesOverride = attributesOverride + ' placeholder="${springMacroRequestContext.getMessage(placeholder)}" '/>
            <#if required>
                <#assign attributesOverride = attributesOverride + ' required '/>
            </#if>
            <@spring.formTextarea path attributesOverride/>
        </div>
        <@spring.showErrors "<br>" "text-danger" />
    </div>
</#macro>

<#macro radioButton path values required=false>
    <@spring.bind path />
    <@spring.showErrors "<br>" "text-danger" />
    <div class="form-group">
        <@spring.formRadioButtons path values "&nbsp;" 'class="styled" ${required?then("required","")}' />
    </div>
</#macro>

<#macro inputTextWithHint path fieldType="text" required=false hintText="" class="" attributes=" " allowed=true>
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
                <@inputText path fieldType required class attributes+"onfocus='hint(this)' onblur='unhint(this)'" allowed />
                <div class="hint form-control">
                    <span><@spring.message "${hintText}"/></span>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function hint(elem) {
            $("div.hint").css("display", "block");
        }

        function unhint(elem) {
            $("div.hint").css("display", "none");
        }
    </script>
</#macro>