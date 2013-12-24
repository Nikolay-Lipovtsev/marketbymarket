<!-- Custom JavaScript for the Menu Toggle -->
function sideBarMenu(){
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("active");
    });
}

