
function toggleDisplay(toggleOnId, toggleOffId)
{

	if (toggleOnId!=null)
	{
	
		document.getElementById(toggleOnId).style.display = "inline";
	}
	if (toggleOffId!=null)
	{
		
		document.getElementById(toggleOffId).style.display = "none";
	}
}

$(document).ready(function () {
	$('label.tree-toggler').click(function () {
		$(this).parent().children('ol.tree').toggle(300);
	});
});

$(document).ready(function(){
    $(this).scrollTop(0);
});

$(window).on('beforeunload', function() {
    $(window).scrollTop(0);
});







