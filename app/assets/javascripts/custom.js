$(function () {
    if ($.support.localStorage)
    {
        $.validator.addMethod("url", function(value, element) {
            return this.optional(element) || /^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/|www\.)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/.test(value);
        }, "Please enter a valid url address.");

        // Validate urlform form
        $("#url_form").validate({
            rules: {
                "url[Url]": "required url"
            }
        });

        $('#url_form').submit(function (e) {
            if($(this).valid()){
//                var content = $('#url').val();
//                e.preventDefault();
//                $("#urls_list").prepend('<li> '+content+'</li>');
//                $(this).trigger('reset');
//                e.preventDefault();
                var pendingItems = $.parseJSON(localStorage["pendingItems"]);
                var url = {"data":$(this).serialize(), "Url":$("#url").val()};
                $("#item_template").tmpl(url).prependTo("#urls_list");
                pendingItems.push(url);
                localStorage["pendingItems"] = JSON.stringify(pendingItems);
                $("#url").val("");
                sendPending();
                e.preventDefault();
            }
            else {

            }
        });

        $(window.applicationCache).bind('error', function () {
            console.log('There was an error when loading the cache manifest.');
        });

        if(!(navigator.onLine)){
            alert("U'r Browser seems to be Offline! \n Your changes will be submitted once online!");
        }

        if (!localStorage["pendingItems"]) {
            localStorage["pendingItems"] = JSON.stringify([]);
        }

        $.retrieveJSON('/urls.json', function(data) {
            var pendingItems = $.parseJSON(localStorage["pendingItems"]);
//            $("#urls_list").html($("#item_template").tmpl(data));
            $("#urls_list").html($("#item_template").tmpl(data.concat(pendingItems)));
        });

//        $('#url_form').submit(function (e) {
//            var pendingItems = $.parseJSON(localStorage["pendingItems"]);
//            var url = {"data":$(this).serialize(), "Url":$("#url").val()};
//            $("#item_template").tmpl(url).prependTo("#urls_list");
//            pendingItems.push(url);
//            localStorage["pendingItems"] = JSON.stringify(pendingItems);
//            $("#url").val("");
////            sendPending();
//            e.preventDefault();
//        });

        function sendPending() {
            if (window.navigator.onLine) {
                var pendingItems = $.parseJSON(localStorage["pendingItems"]);
                if (pendingItems.length > 0) {
                    var url = pendingItems[0];
                    $.post("/urls", url.data, function (data) {
                        var pendingItems = $.parseJSON(localStorage["pendingItems"]);
                        pendingItems.shift();
                        localStorage["pendingItems"] = JSON.stringify(pendingItems);
                        setTimeout(sendPending, 100);
                    });
                }
            }
        }
        sendPending();
        $(window).bind("online", sendPending);
    }
    else {
        alert("Time to upgrade your browser.")
    }
});
