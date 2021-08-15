$(function () {
    const showAsideBtn = document.querySelector('.show-side-btn')
    const sidebar = document.querySelector('.sidebar')
    const wrapper = document.querySelector('#wrapper')

    if (showAsideBtn) {
        showAsideBtn.addEventListener('click', function () {
            document.querySelector(`#${this.dataset.show}`).classList.toggle('show-sidebar');
            wrapper.classList.toggle('fullwidth');
        })
    }

    if (showAsideBtn) {
        if (window.innerWidth < 767) {
            sidebar.classList.add('show-sidebar');
            wrapper.classList.add('fullwidth');
        }

        window.addEventListener('resize', function () {
            if (window.innerWidth > 767) {
                sidebar.classList.remove('show-sidebar');
                wrapper.classList.remove('fullwidth');
            }
        })

        $('.sidebar .categories .has-dropdown').click(function () {
            const dp = $(this);
            dp.toggleClass('opened');
            dp.find('.sidebar-dropdown').toggleClass('active');
        })
    }

    moment.locale("ru");
})


$(function () {
    $(".sidebar-counter").each(function () {
        let element = $(this);
        $.ajax({
            url: $(this).data("count-href"),
            success: function (data) {
                element.text(data);
                if (data <= 0) {
                    return;
                }
                element.removeClass('bg-secondary');
                element.addClass("bg-primary");
            }
        })
    })
})

function drawSelect2(id, url, erase, placeHolder, allowClear) {
    $("#" + id).select2({
        width: "100%",
        placeholder: placeHolder,
        allowClear: allowClear,
        ajax: {
            url: function () {
                return url;
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
                if (data._embedded) {
                    var list = data._embedded.list;

                    for (var index in erase) {
                        for (var key in list) {
                            if (list[key].title == erase[index]) {
                                data._embedded.list.splice(key, 1);
                                break;
                            }
                        }
                    }
                }
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
}