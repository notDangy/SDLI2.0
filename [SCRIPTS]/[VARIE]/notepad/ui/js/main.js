$(document).ready(function () {
    window.addEventListener('message', function (event) {
            $('body').mousemove(function (e) {
                var y = e.pageY;
                var x = e.pageX;

                $('.moveable').css('top', y - 0).css('left', x - 0);
            });

            var notepad = $("#notepad");
            var notetxt = $("#note-txt");

            var notepad2 = $("#notepad2");
            var notetxt2 = $("#note-txt2");
            if (event.data.type === "showpage") {
                $('.moveable').css('display', 'block');

                notepad.css('display', 'block');
                notetxt.focus();

                notepad.on("click", "#drop-note", function () {
                    var data = notetxt.val();

                    notepad.css('display', 'none');

                    if (data !== "") {
                        $.post('http://notepad/getNote', JSON.stringify(data));
                        $('.moveable').css('display', 'none');
                        $.post('http://notepad/NUIFocusOff', JSON.stringify({}));
                        notetxt.val("");
                    } else {
                        notepad.css('display', 'none');
                        $('.moveable').css('display', 'none');
                        $.post('http://notepad/NUIFocusOff', JSON.stringify({}));
                    }
                });

                notepad.on("click", "#save-note", function () {
                    notepad.css('display', 'none');
                    $('.moveable').css('display', 'none');
                    $.post('http://notepad/NUIFocusOff', JSON.stringify({}));
                });
            }

            if (event.data.type === "pickup") {
                $('.moveable').css('display', 'block');
                notepad2.css('display', 'block');

                $("#notepad2 #note-txt2").val(event.data.notetxt);
                notetxt2.focus();

                notepad2.on("click", "#destroy-note", function () {
                    notepad2.css('display', 'none');
                    $('.moveable').css('display', 'none');
                    $.post('http://notepad/NUIFocusOff', JSON.stringify({}));
                });

                notepad2.on("click", "#drop-note2", function () {
                    notepad2.css('display', 'none');
                    $('.moveable').css('display', 'none');
                    $.post('http://notepad/NUIFocusOff', JSON.stringify({}));

                    if (notetxt2.val() !== "") {
                        $.post('http://notepad/getNote', JSON.stringify(event.data.notetxt));
                        notetxt2.val("");
                    }
                });
				
				notepad.on("click", "#save-note2", function () {
                    notepad.css('display', 'none');
                    $('.moveable').css('display', 'none');
                    $.post('http://notepad/NUIFocusOff', JSON.stringify({}));
                });
            }

        }
    );
});