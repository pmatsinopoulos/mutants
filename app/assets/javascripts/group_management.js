$(document).ready(function() {

    $(".modal#modal_dialog").dialog({
        autoOpen: false,
        modal: true
    });

    $("span#group_management_new_task_link_span #new_task_link").
        on("ajax:success", function(e, data, status, xhr) {
            $('#modal_dialog').html(data).
                dialog("open");
        }).on("ajax:beforeSend", function(){
            $('#new_task_link_loader').css('display', 'inline');
            $(this).hide();
        }).on("ajax:complete", function(){
            $('#new_task_link_loader').hide();
            $(this).show();
        });
});