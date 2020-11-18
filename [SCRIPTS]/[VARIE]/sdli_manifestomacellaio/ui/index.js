var resourceName = "";
$(function() {
    var actionContainer = $("body");
    actionContainer.hide();

    window.addEventListener('message', function(event) {
        switch(event.data.action){
            case "init":
                resourceName = event.data.resourceName;
                break;
            case "action1":
                if (event.data.open) {
                    actionContainer.show();
                }
                else {
                    actionContainer.hide(); 
                }
                break;
        }
    });
})

document.onkeyup = function (data) {
	if (data.which == 27) { 
        $.post('http://'+ resourceName +'/escape1', JSON.stringify({}));
	}
}
