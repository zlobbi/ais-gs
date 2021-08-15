<#import "/spring.ftl" as spring>

<#macro print path title="" lastUpdatedAt="" icon="bi bi-pencil-fill" showSubmit=true>
    <form action="${path}" method="POST" role="form" enctype="multipart/form-data">
        <div class="card card-custom">
            <div class="card-header">
                <h5 class="card-text">
                    <i class="${icon}"></i>
                    <@spring.message title />
                </h5>
            </div>
            <div class="card-body">
                <#nested />
                <input type="hidden" name="lastUpdatedAt" value="${lastUpdatedAt}" />
            </div>
            <#if showSubmit>
                <div class="card-footer text-end">
                    <@inputSubmit />
                    <@inputCancel />
                </div>
            </#if>
        </div>
    </form>
</#macro>

<#macro inputSubmit text="action.accept" class="primary">
    <button type="submit" class="btn btn-${class}">
        <@spring.message text />
    </button>
</#macro>

<#macro inputCancel text="action.cancel" class="violet">
    <button type="button" class="btn btn-${class}" onclick="history.back()">
        <@spring.message text />
    </button>
</#macro>

<#macro printSteps id steps>
    <div class="card card-custom">
        <div class="card-body">
            <form action="" method="POST" role="form" enctype="multipart/form-data">
                <div id="${id}">
                    <ul class="nav">
                        <#list steps as key, title>
                            <li>
                                <a class="nav-link" href="#${key}">
                                    <@spring.message title />
                                </a>
                            </li>
                        </#list>
                    </ul>
                    <div class="tab-content h-100">
                        <#nested />
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        $(function () {
            let $errorSteps = [];

            <#list steps as key, title>
                if ($('#${key}').find('.spring-error').length > 0) {
                    $errorSteps.push(#{key?index});
                }
            </#list>

            $('#${id}').smartWizard({
                selected: 0,
                theme: 'dots',
                keyboardSettings: {
                    keyNavigation: true,
                    keyLeft: [37],
                    keyRight: [39]
                },
                toolbarSettings: {
                    toolbarPosition: 'bottom',
                    toolbarButtonPosition: 'left',
                    showNextButton: true,
                    showPreviousButton: true,
                    toolbarExtraButtons: [
                        $('<button></button>')
                            .text('<@spring.message "action.accept" />')
                            .addClass('btn sw-btn-submit')
                            .attr('type', 'submit')
                    ]
                },
                lang: {
                    next: '<@spring.message "table.nextPage" />',
                    previous: '<@spring.message "table.previousPage" />'
                },
                errorSteps: $errorSteps
            });

            $('#${id}').smartWizard("goToStep", 0);

            btnSubmitVisibility(false);


            $('#${id}').on("leaveStep", function(e, anchorObject, currentStepIndex, nextStepIndex, stepDirection) {
                let isBtnSubmitVisible = (anchorObject.prevObject.length - 1 === nextStepIndex);

                if (stepDirection === 'forward') {
                    if ($('#${id}').closest('form').valid()) {
                        btnSubmitVisibility(isBtnSubmitVisible);
                        return true
                    } else {
                        return false
                    }
                } else {
                    btnSubmitVisibility(isBtnSubmitVisible);
                }
                return true;
            })

            function btnSubmitVisibility(visible) {
                if (visible) {
                    $('.sw-btn-submit')
                        .removeClass('disabled')
                        .removeAttr('disabled');
                } else {
                    $('.sw-btn-submit')
                        .addClass('disabled')
                        .attr('disabled', true);
                }
            }
        });
    </script>
</#macro>

<#macro printStep key>
    <div id="${key}" class="tab-pane w-100" role="tabpanel">
        <#nested />
    </div>
</#macro>