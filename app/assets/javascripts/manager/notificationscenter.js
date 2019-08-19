$(document).ready(function()
{
  (function() {
      App.notifications = App.cable.subscriptions.create({
        channel: 'NotificationsChannel'
      },
      {
        connected: function() {},
        disconnected: function() {},
        received: function(data) {
          $('#notificationList').prepend('' + data.notification);
          $('#notificationList li').click(function(){
            window.location.href = $(this).find('a').first().attr('href');
          });

          return this.update_counter(data.counter);
        },
        update_counter: function(counter) {
          var $counter, val;
          $counter = $('#notification-counter');
          val = parseInt($counter.text());
          val++;
          return $counter.css({
          }).text(val)
            .css({
              top: '20%'
            })
        }
      });
  }).call(this);
});
