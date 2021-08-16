<#import "/spring.ftl" as spring/>

<#macro head title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>
        GS
        <#list title as k,v>
            | <@spring.message v/>
        </#list>
    </title>

    <link href="/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/extras/animate.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/icons/fontawesome/styles.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/icons/bootstrap-icons/bootstrap-icons.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="/assets/js/core/libraries/jquery.min.js"></script>
    <script type="text/javascript" src="/assets/js/core/libraries/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/visualization/chart/chart.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/loaders/blockui.min.js"></script>

<#-- DataTables -->
    <link href="/assets/css/datatables/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/autoFill.bootstrap5.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/buttons.bootstrap5.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/colReorder.bootstrap5.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/fixedColumns.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/fixedHeader.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/keyTable.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/responsive.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/rowGroup.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/rowReorder.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/scroller.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/searchBuilder.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/searchPanes.dataTables.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/datatables/extensions/select.dataTables.min.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/dataTables.bootstrap5.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.autoFill.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/autoFill.bootstrap5.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.buttons.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/buttons.bootstrap5.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/buttons.colVis.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/buttons.html5.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/buttons.print.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.colReorder.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.fixedColumns.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.fixedHeader.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.keyTable.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.responsive.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.rowGroup.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.rowReorder.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.scroller.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.searchBuilder.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.searchPanes.min.js"></script>
    <script type="text/javascript"
            src="/assets/js/plugins/tables/datatables/extensions/dataTables.select.min.js"></script>

<#-- Select2 -->
    <link href="/assets/css/plugins/select2/select2.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/plugins/forms/selects/select2.full.min.js"></script>

<#-- Daterangepicker -->
    <link href="/assets/css/plugins/daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/plugins/ui/moment/moment-with-locales.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/pickers/daterangepicker.js"></script>

<#-- Anytime -->
    <link href="/assets/css/plugins/anytime/anytime.5.2.0.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/plugins/pickers/anytime/anytime.5.2.0.min.js"></script>

<#-- jQuery Validation -->
    <script type="text/javascript" src="/assets/js/plugins/forms/validation/jquery.validate.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/forms/validation/additional-methods.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/forms/validation/localization/messages_ru.js"></script>

<#-- VUEJS -->
    <script type="text/javascript" src="/assets/js/core/vue-components/axios.min.js"></script>

<#-- Main -->
    <link href="/assets/css/app.css" rel="stylesheet" type="text/css">

    <script>
        srvTime = new Date(${.now?long?c}).getTime();
        timesDiff = new Date().getTime() - srvTime;
    </script>
</#macro>

<#macro ribbon profile = 'default'>
    <div class="ribbon">
        <small>
            <@spring.message profile />
        </small>
    </div>
</#macro>

<#macro sidebar>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-auto bg-light sticky-top">
                <div class="d-flex flex-sm-column flex-row flex-nowrap bg-light align-items-center sticky-top">
                    <a href="/" class="d-block p-3 link-dark text-decoration-none" title="" data-bs-toggle="tooltip"
                       data-bs-placement="right" data-bs-original-title="Icon-only">
                        <i class="bi-bootstrap fs-1"></i>
                    </a>
                    <ul class="nav nav-pills nav-flush flex-sm-column flex-row flex-nowrap mb-auto mx-auto text-center align-items-center">
                        <li class="nav-item">
                            <a href="#" class="nav-link link-success py-3 px-2" title="" data-bs-toggle="tooltip"
                               data-bs-placement="right" data-bs-original-title="Home">
                                <i class="bi-house fs-1"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="nav-link py-3 px-2" title="" data-bs-toggle="tooltip"
                               data-bs-placement="right" data-bs-original-title="Dashboard">
                                <i class="bi-speedometer2 fs-1"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="nav-link py-3 px-2" title="" data-bs-toggle="tooltip"
                               data-bs-placement="right" data-bs-original-title="Orders">
                                <i class="bi-table fs-1"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="nav-link py-3 px-2" title="" data-bs-toggle="tooltip"
                               data-bs-placement="right" data-bs-original-title="Products">
                                <i class="bi-heart fs-1"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="nav-link py-3 px-2" title="" data-bs-toggle="tooltip"
                               data-bs-placement="right" data-bs-original-title="Customers">
                                <i class="bi-people fs-1"></i>
                            </a>
                        </li>
                    </ul>
                    <div class="dropdown">
                        <a href="#"
                           class="d-flex align-items-center justify-content-center p-3 link-dark text-decoration-none dropdown-toggle"
                           id="dropdownUser3" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi-person-circle h2"></i>
                        </a>
                        <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser3">
                            <li><a class="dropdown-item" href="#">New project...</a></li>
                            <li><a class="dropdown-item" href="#">Settings</a></li>
                            <li><a class="dropdown-item" href="#">Profile</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-sm p-3 min-vh-100">
                <#nested />
            </div>
        </div>
    </div>
</#macro>

<#macro render breadcrumb={} title={}>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <@head title />
    </head>

    <body>
    <@sidebar>
        <#nested />
    </@sidebar>
    </body>
    </html>
</#macro>
