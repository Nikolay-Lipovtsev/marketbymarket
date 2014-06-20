// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

// Loads all Bootstrap javascripts
//= require bootstrap
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require bootstrap-select
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js

var ready;
ready = function() {

    //Bootstrap datepicker rails default settings for signup

    $('.sandbox-container.birthday input').datepicker({
        endDate: dateNow,
        startView: 2,
        autoclose: true,
        format: "dd/mm/yyyy",
        todayBtn: "linked",
        language: locale,
        todayHighlight: true
    });

    $('.sandbox-container.gefault input').datepicker({
        autoclose: true,
        format: "dd/mm/yyyy",
        todayBtn: "linked",
        language: locale,
        todayHighlight: true
    });

};

$(document).ready(ready);
$(document).on('page:load', ready);


