var ready;
ready = function() {

    //Bootstrap popover

    $('input.popover-add').popover({
        delay: { show: 500, hide: 100 },
        container: 'body',
        trigger: 'focus'
    });

};

$(document).ready(ready);
$(document).on('page:load', ready);