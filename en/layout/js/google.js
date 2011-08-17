/* $FreeBSD: www/en/layout/js/google.js,v 1.5 2011/08/17 13:58:23 gjb Exp $ */

var h=document.location.host;
/*
 * Check that the hosting domain is actually a FreeBSD.org domain, so
 * we don't accidentally obtain data from mirrors.
 */
var fbsdregex=/(docs|www|wiki)\.freebsd\.org/i;
if (fbsdregex.test(h)) {
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-22767463-1']);
	_gaq.push(['_trackPageview']);
	_gaq.push(['_setCustomVar',
		5, // use the last index in case we just don't care ;-)
		'Real Operating System',
		navigator.platform,
		1 // Lets track this by 'visitor' (per cookie). If we need more
		// fine grained data we could always change it later
		]);

	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = 'https://ssl.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();

}

