
function install(link) {
	if (typeof(window.external) != 'undefined' && typeof(window.external.AddSearchProvider) != 'undefined') {
		window.external.AddSearchProvider(link.href);
		return false;
	} else {
		return confirm("The plugin couldn’t be installed automatically.  Display it instead?");
	}
}

