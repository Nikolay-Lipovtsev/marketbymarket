
//Actions On resize document

$(window).resize(function(){

});

//Actions On document ready

var ready;
ready = function() {

    //Side bar menu toggle
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("active");
    });


    $("#sidebar-wrapper [data-toggle=collapse]").click(function(){

        // toggle icon
        $(this).find("i.angle").toggleClass("fa-angle-right fa-angle-down");

    });

    $('.selectpicker').selectpicker();
};

$(document).ready(ready);
$(document).on('page:load', ready);