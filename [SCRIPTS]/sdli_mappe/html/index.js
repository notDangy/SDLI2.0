var resourceName = "";
$(function() {
    var actionContainer = $("body");
    actionContainer.hide();

    window.addEventListener('message', function(event) {
        console.log(event.data.action);
        switch(event.data.action){
            case "init":
                resourceName = event.data.resourceName;
                break;
            case "toggle":
                if (event.data.showmap) {
                      
                    document.body.innerHTML = '<img src="' + event.data.image + '" width="1600" height="865">';
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
        $.post('http://'+ resourceName + '/escape', JSON.stringify({}));
	}
}
