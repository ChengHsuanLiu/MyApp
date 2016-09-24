App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    $('#messages').append(data['message']);
    $("html, body").animate({ scrollTop: $(document).height()-$(window).height() }, 300);
  },
  speak: function(message, user_id) {
  	console.log('speak');
    return this.perform('speak', {
      message: message,
      user_id: user_id
    });
  }
});

$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
  var user_id = $('#message-input').attr('user-id');
  if(event.target.value != '' && event.keyCode === 13){
    App.room.speak(event.target.value, user_id);
    event.target.value = '';
    return event.preventDefault();
  }
});

$(document).on('click', '#submit-btn', function(event) {
  if($('#message-input').val() != ''){
    var user_id = $('#message-input').attr('user-id');
    App.room.speak($('#message-input').val(), user_id);
    $('#message-input').val('');
  }
  return event.preventDefault();
});

