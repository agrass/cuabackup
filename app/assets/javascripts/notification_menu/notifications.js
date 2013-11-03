$(function () {

    var notifications_bar = new $.ttwNotificationMenu({
        notificationClickCallback:function(notification){
            console.log(notification.settings.link);

        },
        deleteCallback:
            function(notification){
                console.log(notification.settings.delete_link);

            }
    });
    var notifications_url = $('#alarms').attr("data-notifications-url");
    notifications = {};

    //Add bubbles to a menu
    notifications_bar.initMenu({
        alarms: '#alarms'
    });

    //create a notification
    // notifications.createNotification('Sample Notification');

    refreshIntervalId = 0;
    clearInterval(refreshIntervalId);
    get_notifications();
    refreshIntervalId = setInterval(get_notifications, 10000);

    function get_notifications() {
        $.get(notifications_url, function (notifications_data) {
            $.each(notifications_data, function (key, notification) {
                //notifications.push(notification.id : notification);
                if (!notifications[notification.id]) {
                    notifications[notification.id] = notification;
                    notifications_bar.createNotification({
                        message: notification.message,
                        category: 'alarms',
                        delete_link: notification.delete_link,
                        link: notification.link
                    });
                }

            });
        });
    }

});

