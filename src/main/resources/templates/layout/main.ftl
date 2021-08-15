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

<#--Forms-->
    <script type="text/javascript" src="/assets/js/plugins/forms/styling/uniform.min.js"></script>
<#--Forms-->

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
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.autoFill.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/autoFill.bootstrap5.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/buttons.bootstrap5.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/buttons.colVis.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/buttons.html5.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/buttons.print.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.colReorder.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.fixedColumns.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.fixedHeader.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.keyTable.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.rowGroup.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.rowReorder.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.scroller.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.searchBuilder.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.searchPanes.min.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/tables/datatables/extensions/dataTables.select.min.js"></script>
<#-- DataTables end -->

<#-- Select2 -->
    <link href="/assets/css/plugins/select2/select2.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/plugins/forms/selects/select2.full.min.js"></script>
<#-- Select2 end -->

<#-- Daterangepicker -->
    <link href="/assets/css/plugins/daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/plugins/ui/moment/moment-with-locales.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/pickers/daterangepicker.js"></script>
<#-- Daterangepicker end -->

<#-- Anytime -->
    <link href="/assets/css/plugins/anytime/anytime.5.2.0.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/plugins/pickers/anytime/anytime.5.2.0.min.js"></script>
<#-- Anytime end -->

<#-- Sweetalert2 -->
    <link href="/assets/css/plugins/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/plugins/notifications/sweetalert2.min.js"></script>
<#-- Sweetalert2 end -->

<#-- SmartWizard -->
    <link href="/assets/css/plugins/smart_wizard/smart_wizard_all.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/plugins/forms/smart_wizard/jquery.smartWizard.js"></script>
<#-- SmartWizard end -->

<#-- jQuery Validation -->
    <script type="text/javascript" src="/assets/js/plugins/forms/validation/jquery.validate.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/forms/validation/additional-methods.js"></script>
    <script type="text/javascript" src="/assets/js/plugins/forms/validation/localization/messages_ru.js"></script>
<#-- jQuery Validation end -->

<#-- VUEJS -->
    <script type="text/javascript" src="/assets/js/core/vue-components/vue.js"></script>
    <script type="text/javascript" src="/assets/js/core/vue-components/axios.min.js"></script>
<#-- VUEJS end -->

<#-- Map -->
    <script type="text/javascript" src="/assets/js/heatmap/OpenLayers.js"></script>
<#-- Map -->

<#-- Main -->
    <link href="/assets/css/app.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/assets/js/core/app.js"></script>
<#-- Main end -->

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
        <div class="row flex-nowrap">
            <div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
                <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100">
                    <a href="/"
                       class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                        <span class="fs-5 d-none d-sm-inline">Menu</span>
                    </a>
                    <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start"
                        id="menu">
                        <li class="nav-item">
                            <a href="#" class="nav-link align-middle px-0">
                                <i class="fs-4 bi-house"></i> <span class="ms-1 d-none d-sm-inline">Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="#submenu1" data-bs-toggle="collapse" class="nav-link px-0 align-middle">
                                <i class="fs-4 bi-speedometer2"></i> <span
                                        class="ms-1 d-none d-sm-inline">Dashboard</span> </a>
                            <ul class="collapse show nav flex-column ms-1" id="submenu1" data-bs-parent="#menu">
                                <li class="w-100">
                                    <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Item</span> 1
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Item</span> 2
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="nav-link px-0 align-middle">
                                <i class="fs-4 bi-table"></i> <span class="ms-1 d-none d-sm-inline">Orders</span></a>
                        </li>
                        <li>
                            <a href="#submenu2" data-bs-toggle="collapse" class="nav-link px-0 align-middle ">
                                <i class="fs-4 bi-bootstrap"></i> <span class="ms-1 d-none d-sm-inline">Bootstrap</span></a>
                            <ul class="collapse nav flex-column ms-1" id="submenu2" data-bs-parent="#menu">
                                <li class="w-100">
                                    <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Item</span>
                                        1</a>
                                </li>
                                <li>
                                    <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Item</span>
                                        2</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#submenu3" data-bs-toggle="collapse" class="nav-link px-0 align-middle">
                                <i class="fs-4 bi-grid"></i> <span class="ms-1 d-none d-sm-inline">Products</span> </a>
                            <ul class="collapse nav flex-column ms-1" id="submenu3" data-bs-parent="#menu">
                                <li class="w-100">
                                    <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Product</span> 1</a>
                                </li>
                                <li>
                                    <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Product</span> 2</a>
                                </li>
                                <li>
                                    <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Product</span> 3</a>
                                </li>
                                <li>
                                    <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Product</span> 4</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="nav-link px-0 align-middle">
                                <i class="fs-4 bi-people"></i> <span class="ms-1 d-none d-sm-inline">Customers</span>
                            </a>
                        </li>
                    </ul>
                    <hr>
                    <div class="dropdown pb-4">
                        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                           id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="https://github.com/mdo.png" alt="hugenerd" width="30" height="30"
                                 class="rounded-circle">
                            <span class="d-none d-sm-inline mx-1">loser</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
                            <li><a class="dropdown-item" href="#">New project...</a></li>
                            <li><a class="dropdown-item" href="#">Settings</a></li>
                            <li><a class="dropdown-item" href="#">Profile</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#">Sign out</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col py-3">
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
