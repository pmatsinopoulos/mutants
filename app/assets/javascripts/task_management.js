$(document).on('ajax:success', 'form#task_form', function(e, data, status, xhr){
    $('#modal_dialog').dialog('close');
    // add the response to the available options
    $('select#tasks option:eq(0)').after(data);
    $('select#tasks').trigger("chosen:updated");
}).on('ajax:error', 'form#task_form', function(e, xhr, status, error){
    $('form#task_form').html(xhr.responseText);
}).on('ajax:beforeSend', 'form#task_form', function(){
    $('#create_task_submit_loader').css('display', 'inline');
    $('#save_task').prop('disabled', true);
}).on('ajax:complete', 'form#task_form', function(){
    $('#create_task_submit_loader').hide();
    $('#save_task').prop('disabled', false);
});
