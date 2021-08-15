<#import "/spring.ftl" as spring>
<#import "form/horizontal-form.ftl" as form>

<#macro render table rowNumber=false>
    <div class="card card-table">
        <div class="card-header d-flex justify-content-between">
            <h5>${table.title()}</h5>
            <button type="button" class="btn btn-light rounded-pill" id="${table.tableId()}-reload">
                <i class="bi bi-arrow-repeat"></i>
            </button>
        </div>
        <div class="card-body">
            <div class="row">
                <div id="${table.tableId()}-filter" class="col-12 collapse">
                    <#if table.hasFilters()>
                        <form id="${table.tableId()}-filter-form">
                            <div class="row">
                                <#assign filters = table.getFilters()>
                                <#list 0..filters?size-1 as i>
                                    <div class="col-4">
                                        <@.vars[filters[i].node()] filters[i] />
                                    </div>
                                </#list>
                            </div>
                            <div class="text-end">
                                <a id="${table.tableId()}-filter-search" class="btn btn-primary">
                                    ${springMacroRequestContext.getMessage("action.accept")}
                                </a>
                                <button type="reset" class="btn btn-danger" id="${table.tableId()}-filter-clear">
                                    ${springMacroRequestContext.getMessage("action.reset")}
                                </button>
                            </div>
                        </form>
                    </#if>
                </div>
                <div class="col-12">
                    <div class="table-responsive">
                        <table id="${table.tableId()}" class="table table-sm table-bordered table-hover w-100">
                            <thead class="table-light">
                            <tr>
                                <#if rowNumber>
                                    <th scope="col" class="sorting_disabled">№</th>
                                </#if>
                                <#list table.getColumns() as column>
                                    <th scope="col">${column.getTitle()}</th>
                                </#list>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            let columns = JSON.parse('${table.getJsonColumn()}'.replace(/&quot;/g, '"'));
            <#if rowNumber>
            columns.unshift({
                data: "id",
                name: "id"
            });

            function setRowNo() {
                let start = ${table.tableCamelCaseId()}dataTable.page.info().start;
                ${table.tableCamelCaseId()}dataTable.column(0).nodes().each(function (cell, i) {
                    cell.innerHTML = start + i + 1;
                });
            }

            </#if>

            let headerDom = '<"col-lg-12 px-0"<"d-flex justify-content-lg-between-or-center"B<"d-none d-sm-none d-md-none d-lg-block d-xl-block d-xxl-block"l>>>';
            let middleDom = '<"col-lg-12 pt-2 px-0"t>';
            let footerDom = '<"col-lg-12 pt-2 px-0"<"d-flex justify-content-lg-between-or-center"<"d-none d-sm-none d-md-none d-lg-block d-xl-block d-xxl-block"i>p>>';

            let l =
                '<div class="input-group"> ' +
                '   <div class="input-group-text bg-white">' +
                '       <@spring.message 'table.showRowsStart'/>' +
                '   </div>' +
                '   _MENU_' +
                '</div>';
            let i =
                '<span class="btn border" style="cursor: default;">' +
                '   <@spring.message 'table.showingPageBegin'/> _START_  <@spring.message 'table.showingPageMiddle'/> _END_ <@spring.message 'table.showingPageEnd'/> _TOTAL_' +
                '</span>';

            let ${table.tableCamelCaseId()}dataTable = $('#${table.tableId()}').DataTable({
                autoWidth: ${table.getAutoWidth()?c},
                dom: '<"row"' + headerDom + middleDom + footerDom + '>',
                processing: true,
                bSort: false,
                serverSide: true,
                bFilter: false,
                scrollX: true,
                colReorder: true,
                language: {
                    lengthMenu: l,
                    zeroRecords: "<@spring.message 'table.nothingToShow' />",
                    info: i,
                    infoEmpty: "",
                    search: "<@spring.message 'table.search' />:",
                    paginate: {
                        first: "<@spring.message 'table.firstPage' />",
                        previous: "<i class='bi bi-caret-left-fill'></i>",
                        next: "<i class='bi bi-caret-right-fill'></i>",
                        last: "<@spring.message 'table.lastPage' />"
                    },
                    select: {
                        rows: {
                            0: "",
                            _: '<span class="btn border" style="cursor: default;"><@spring.message "table.selectRow" /></span>'
                        }
                    }
                },
                select: {
                    style: 'single'
                },
                pageLength: ${table.getRowsPerPage()},
                order: '${table.order()}'.replace(/&quot;/g, '"'),
                ajax: {
                    url: "${table.url()}",
                    type: 'POST',
                    contentType: "application/json",
                    dataFilter: function (data) {
                        return data;
                    },
                    data: function (d) {
                        return JSON.stringify(d);
                    }
                },
                <#if rowNumber>
                drawCallback: setRowNo,
                </#if>
                columns: columns,
                buttons: [
                    {
                        extend: 'colvis',
                        text: '<i class="bi bi-gear-fill"></i> <@spring.message "table.columns" />',
                        init: (api, node, config) => $(node).removeClass('btn-secondary'),
                        align: 'button-left'
                    },
                    <#if table.hasFilters()>
                    {
                        text: '<i class="bi bi-filter"></i> <@spring.message "table.filters" />',
                        init: (api, node, config) => $(node).removeClass('btn-secondary'),
                        action: function () {
                            $('#${table.tableId()}-filter.collapse').collapse('toggle')
                        }
                    },
                    </#if>
                    <#if table.hasDropDownButtons()>
                    <#list table.getDropDownButtons() as dropDownButton >
                    <#if dropDownButton?has_content && dropDownButton.getButtons()?has_content>
                    {
                        extend: 'collection',
                        text: '${dropDownButton.text()}',
                        init: (api, node, config) => {
                            if ('btn-${dropDownButton.getColor()}' !== 'btn-secondary') {
                                $(node).removeClass('btn-secondary');
                            }
                        },
                        className: 'btn-${dropDownButton.getColor()}',
                        buttons: [
                            <#list dropDownButton.getButtons() as button >
                            {
                                text: '${button.text()}',
                                action: function () {
                                    if (${table.tableCamelCaseId()}dataTable.rows('.selected').data().length <= 0 && true == ${button.needSelected?c}) {
                                        Swal.fire(
                                            'Внимание!',
                                            'Для работы выделите строку',
                                            'warning'
                                        )
                                        return;
                                    }

                                    let id = null;
                                    if (${table.tableCamelCaseId()}dataTable.rows('.selected').data().toArray().length > 0) {
                                        id = ${table.tableCamelCaseId()}dataTable.rows('.selected').data().toArray()[0].uuid;
                                    }

                                    <#if button.getButtonType().toString() == "function">
                                    Swal.fire({
                                            title: "<@spring.message '${button.getTitle()}'/>?",
                                            text: "<@spring.message 'action.dialog.accept-question'/>",
                                            type: "warning",
                                            showCancelButton: true,
                                            confirmButtonColor: "#EF5350",
                                            confirmButtonText: '<@spring.message 'action.dialog.accept'/>',
                                            cancelButtonText: "<@spring.message 'action.dialog.cancel'/>",
                                            closeOnConfirm: true,
                                            closeOnCancel: true
                                        },
                                        function (isConfirm) {
                                            if (!isConfirm) {
                                                return;
                                            }
                                            $.ajax({
                                                url: "${button.getActionUrl()}" + ((id != null) ? "?id=" + id : ""),
                                                type: "${button.getMethod()!"get"}",
                                                success: function (data) {
                                                    ${table.tableCamelCaseId()}dataTable.rows('.selected').deselect();
                                                    ${table.tableCamelCaseId()}dataTable.ajax.reload();
                                                },
                                                error: function (e1, e2, e3) {
                                                    setTimeout(function () {
                                                        swal({
                                                            title: "Внимание!",
                                                            text: e1.responseJSON.message,
                                                            type: "warning"
                                                        });
                                                    }, 1000)
                                                }
                                            })
                                        }
                                    );
                                    <#elseif button.getButtonType().toString() == "action">
                                    <#if button.isDialog()>
                                    Swal.fire({
                                            title: "<@spring.message '${button.getTitle()}'/>?",
                                            text: "<@spring.message 'action.dialog.accept-question'/>",
                                            type: "warning",
                                            showCancelButton: true,
                                            confirmButtonColor: "#EF5350",
                                            confirmButtonText: '<@spring.message 'action.dialog.accept'/>',
                                            cancelButtonText: "<@spring.message 'action.dialog.cancel'/>",
                                            closeOnConfirm: true,
                                            closeOnCancel: true
                                        },
                                        function (isConfirm) {
                                            if (!isConfirm) {
                                                return;
                                            }
                                            window.open("${button.getActionUrl()}" + (id != null ? "?id=" + id : ""), "_self");
                                        }
                                    );
                                    <#else>
                                    window.open("${button.getActionUrl()}" + (id != null ? "?id=" + id : ""), "_self");
                                    </#if>
                                    </#if>
                                }
                            },
                            </#list>
                        ]
                    },
                    </#if>
                    </#list>
                    </#if>
                    <#list table.getButtons() as button >
                    {
                        text: '${button.text()}',
                        init: (api, node, config) => {
                            if ('btn-${button.getColor()}' !== 'btn-secondary') {
                                $(node).removeClass('btn-secondary');
                            }
                        },
                        className: 'btn-${button.getColor()}',
                        action: function () {
                            window.open('${button.getActionUrl()}', '${button.getActionTarget()!"_self"}');
                        }
                    },
                    </#list>
                ],
                rowCallback: function (row, data, dataIndex) {
                }
            });


            ${table.tableCamelCaseId()}dataTable
                .on('select', function (e, dt, type, indexes) {
                    let rowData = ${table.tableCamelCaseId()}dataTable.rows(indexes).data().toArray()[0];
                    ${table.tableCamelCaseId()}dataTableSelectedRow(rowData);
                })
                .on('deselect', function (e, dt, type, indexes) {
                    let rowData = ${table.tableCamelCaseId()}dataTable.rows(indexes).data().toArray()[0];
                    ${table.tableCamelCaseId()}dataTableDeselectedRow(rowData);
                })
                .on("page.dt", function () {
                    ${table.tableCamelCaseId()}dataTable.rows('.selected').deselect();
                });

            $("#${table.tableId()}-reload").click(function () {
                ${table.tableCamelCaseId()}dataTable.ajax.reload();
            });

            $("#${table.tableId()}-filter-search").click(function () {
                let queryData = $('#${table.tableId()}-filter-form').serialize();
                ${table.tableCamelCaseId()}dataTable.ajax.url("${table.url()}?" + queryData);
                ${table.tableCamelCaseId()}dataTable.ajax.reload();
            });

            $("#${table.tableId()}-filter-clear").click(function () {
                $('#${table.tableId()}-filter').find('select').val('').trigger('change');
                ${table.tableCamelCaseId()}dataTable.ajax.url("${table.url()}");
                ${table.tableCamelCaseId()}dataTable.ajax.reload();
            });

            <#if rowNumber>
            $('#${table.tableId()}_wrapper')
                .find('.dataTables_scrollHeadInner')
                .find('th')
                .first()
                .css('padding-right', '25px');
            </#if>

            ${table.tableCamelCaseId()}dataTable.on('preXhr.dt', function (e, settings, processing) {
                $(this).parents('.dataTables_scroll').block({
                    message: '<i class="icon-spinner2 spinner"></i>',
                    overlayCSS: {
                        backgroundColor: '#fff',
                        opacity: 0.8,
                        cursor: 'wait'
                    },
                    css: {
                        border: 0,
                        padding: 0,
                        backgroundColor: 'none'
                    }
                });
            });

            ${table.tableCamelCaseId()}dataTable.on('xhr.dt', function (e, settings, processing) {
                $(this).parents('.dataTables_scroll').unblock();
            });

            $(window).resize(function () {
                ${table.tableCamelCaseId()}dataTable.columns.adjust().draw();
            });

            $('.show-side-btn').click(function () {
                ${table.tableCamelCaseId()}dataTable.columns.adjust().draw();
            })
        })

        var ${table.tableCamelCaseId()}dataTableSelectedRow = function (data) {

        };

        var ${table.tableCamelCaseId()}dataTableDeselectedRow = function (data) {

        };

        $().ready(function () {
            $('.dataTables_length select').select2({
                minimumResultsForSearch: Infinity,
                width: 'auto'
            });
        });
    </script>
</#macro>

<#macro text filter >
    <div class="mb-3">
        <label class="form-label">${filter.title()}:</label>
        <input type="text" name="${filter.name()}" class="form-control" value="" placeholder="${filter.title()}">
    </div>
</#macro>

<#macro selectStatic filter allowClear=true>
    <#assign replacedPath = filter.name()?replace(".", "-") />
    <#assign selectId = "select-id-${replacedPath}" />

    <div class="mb-3">
        <label class="form-label">${filter.title()}:</label>
        <select id="${selectId}" name="${filter.name()}">
            <option selected></option>
            <#list filter.getOptions() as option>
                <option value="${option.getSelectorId()}">${option.getSelectorTitle()}</option>
            </#list>
        </select>
    </div>

    <script type="application/javascript">
        $(function () {
            $("#${selectId}").select2({
                width: "100%",
                allowClear: ${allowClear?c},
                placeholder: "",
                minimumResultsForSearch: Infinity
            });
        });
    </script>
</#macro>

<#macro selectStaticMultiple filter allowClear=false>
    <#assign replacedPath = filter.name()?replace(".", "-") />
    <#assign selectId = "select-id-${replacedPath}" />

    <div class="mb-3">
        <label class="form-label">${filter.title()}: </label>
        <select id="${selectId}" name="${filter.name()}" multiple>
            <#list filter.getOptions() as option>
                <option value="${option.getSelectorId()}">${option.getSelectorTitle()}</option>
            </#list>
        </select>
    </div>

    <script type="application/javascript">
        $(function () {
            $("#${selectId}").select2({
                width: "100%",
                allowClear: ${allowClear?c},
                placeholder: "",
                minimumResultsForSearch: Infinity
            });
        });
    </script>
</#macro>

<#macro checkbox filter>
    <#assign replacedPath = filter.name()?replace(".", "-") />

    <div class="form-check">
        <input type="checkbox" name="${replacedPath}" class="form-check-input" id="${replacedPath}">
        <label class="form-check-label" for="${replacedPath}">
            ${filter.title()}
        </label>
    </div>
</#macro>

<#macro month filter>
    <#assign replacedPath = filter.name()?replace(".", "-") />

    <div class="mb-3">
        <label class="form-label">${filter.title()}:</label>
        <div class="input-group">
            <span class="input-group-text">
                <i class="icon-calendar22"></i>
            </span>
            <input type="text" name="${replacedPath}" id="${replacedPath}" class="form-control"
                   value="${.now?datetime?string('MM.yyyy')}"/>
        </div>
    </div>

    <script>
        $(function () {
            $('#${replacedPath}').datepicker(
                {
                    autoclose: true,
                    format: "mm.yyyy",
                    startView: "year",
                    minViewMode: "months"
                });
        });
    </script>
</#macro>

<#macro dateRange filter >
    <div class="mb-3">
        <label class="form-label">${filter.title()}: </label>
        <div class="input-group">
            <span class="input-group-text">
                <i class="icon-calendar22"></i>
            </span>
            <input name="${filter.name()}Range" type="text" class="form-control daterange-filter-${filter.name()}">
            <input name="${filter.name()}Start" type="hidden" id="${filter.name()}StartDate">
            <input name="${filter.name()}End" type="hidden" id="${filter.name()}EndDate">
        </div>
    </div>

    <script>
        $(function () {
            let selector = $('.daterange-filter-${filter.name()}');

            selector.daterangepicker({
                applyClass: 'bg-slate-600',
                cancelClass: 'btn-default',
                locale: {
                    format: 'DD.MM.YYYY',
                    firstDay: 1
                }
            });

            selector.on('apply.daterangepicker', function (ev, picker) {
                var startDate = picker.startDate.format('DD.MM.YYYY HH:mm');
                var endDate = picker.endDate.format('DD.MM.YYYY HH:mm');

                $("#${filter.name()}EndDate").val(endDate);
                $("#${filter.name()}StartDate").val(startDate);
            });
        });
    </script>
</#macro>

<#macro select filter allowClear=true>
    <#assign replacedPath = filter.name()?replace(".", "-") />
    <#assign selectId = "select-id-${replacedPath}" />
    <#assign replacedPath = filter.name()?replace(".", "") />

    <div class="mb-3">
        <label class="form-label">${filter.title()}: </label>
        <select id="${selectId}" name="${filter.name()}">
            <option selected></option>
        </select>
    </div>

    <script type="application/javascript">
        let select2${replacedPath} = "${filter.url()}";
        $(function () {
            $("#${selectId}").select2({
                width: "100%",
                allowClear: ${allowClear?c},
                placeholder: "",
                ajax: {
                    url: function () {
                        return select2${replacedPath};
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