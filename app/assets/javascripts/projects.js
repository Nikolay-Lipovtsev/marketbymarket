
//Actions On resize document

$(window).resize(function(){

});

//Actions On document ready

var ready;
ready = function() {
    sideBarMenu()
};

$(document).ready(ready);
$(document).on('page:load', ready);