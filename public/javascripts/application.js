// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function mark_for_destroy (element) {
	$(element).next('.should_destroy').value = 1;
	$(element).up('.planning').hide();
}

function mark_membre_for_destroy (element) {
	$(element).next('.should_destroy').value = 1;
	$(element).up('.membres').hide();
}

function mark_article_for_destroy(element) {
	$(element).next('.should_destroy').value = 1;
	$(element).up('.membres').hide();
}

function newImage(arg) {
	if (document.images) {
		rslt = new Image();
		rslt.src = arg;
		return rslt;
	}
}

function changeImages() {
	if (document.images && (preloadFlag == true)) {
		for (var i=0; i<changeImages.arguments.length; i+=2) {
			document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
		}
	}
}

var preloadFlag = false;
function preloadImages() {
	if (document.images) {
		Layout_Accueil_over = newImage("/images/Layout_Accueil-over.png");
		Layout_RECHERCHER_over = newImage("/images/Layout_RECHERCHER-over.png");
		Layout_SE_REFERENCER_over = newImage("/images/Layout_SE-REFERENCER-over.png");
		preloadFlag = true;
	}
}

