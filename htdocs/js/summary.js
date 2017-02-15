$(document).ready(function(){

    var request;

    $('.edit-event-button').click(function(event) {
        event.preventDefault();
        var id = $.parseJSON($(this).attr('data-id'));

        // load the form into the placeholder
        var formPlaceholder = '#event-'+id+' > .edit-form-placeholder';
        var errorContainer = '#event-'+id+' > .error-container';
        $(formPlaceholder).load(BASE_URL + 'summary/ajax_get_event_form', { event_id: id }, function() {
            $('#event-'+id).addClass('edit-mode');

            // disable all edit buttons
            $('.edit-event-button').prop('disabled', true);

            // focus the textarea
            $('#event-'+id+' textarea').focus();

            // register jquery datepicker
            $('.datepicker-input').datepicker();

            // cancel button
            $(formPlaceholder + ' .cancel-edit-form').click(function(e) {
                e.preventDefault();
                $(formPlaceholder).empty();
                $(errorContainer).empty();
                $('.edit-event-button').prop('disabled', false);
                $('#event-'+id).removeClass('edit-mode');
            });

            // delete button
            $(formPlaceholder + ' .delete-event-button').click(function(e) {
                e.preventDefault();

                if (request) {
                    request.abort();
                }

                request = $.ajax({
                    url: 'summary/ajax_delete',
                    type: 'POST',
                    data: {event_id: id},
                    success: function(response) {
                        if (response.length > 0){
                            var errorString = '';
                            for (var i in response){
                                errorString = errorString + '<li>' + response[i] + '</li>';
                            }

                            $(errorContainer).html('<p></p>' + errorString);
                        } else {
                            // on success hide this event entry and show other edit buttons again
                            $('#event-'+id).html(LANG['p_event_has_been_deleted']);
                            $('.edit-event-button').prop('disabled', false);
                        }
                    },
                    dataType: 'json'
                });

                request.fail(function(jqXHR, textStatus) {
                    console.error(LANG['error_an_error_occured'] + ' ' + textStatus, errorThrown);
                });
            });

            // register ajax submit handler
            $('#summary-edit-form-'+id).submit(function(e) {
                if (request) {
                    request.abort();
                }

                var form = $(this),
                    url = form.attr('action'),
                    type = form.attr('method'),
                    data = {};

                var inputs = form.find("input, select, button, textarea");
                var serializedData = form.serialize();
                inputs.prop('disabled', true);

                request = $.ajax({
                    url: url,
                    type: type,
                    data: serializedData,
                    success: function(response) {
                        if (response.length > 0){
                            var errorString = '';
                            for (var i in response){
                                errorString = errorString + '<li>' + response[i] + '</li>';
                            }

                            $(errorContainer).html('<p></p>' + errorString);
                        } else {
                            // on success reload the page to update the event feed
                            $('.edit-event-button').prop('disabled', false);
                            location.reload();
                        }
                    },
                    dataType: 'json'
                });

                request.fail(function (jqXHR, textStatus, errorThrown){
                    console.error(LANG['error_an_error_occured'] + ' ' + textStatus, errorThrown);
                });

                request.always(function () {
                    inputs.prop('disabled', false);
                });

                // prevent default posting of form
                e.preventDefault();
            });
        });
    });

    $('.show-irrelevant-events-button').click(function(event) {
        var button = $(this);
        var group = $.parseJSON($(this).attr('data-group'));

        $('.event.irrelevant.group-'+group).show();
        button.hide();
    });
});