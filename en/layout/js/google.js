/* $FreeBSD: www/en/layout/js/google.js,v 1.6 2011/08/17 21:40:30 gjb Exp $ */

var h=document.location.host;
/*
 * Check that the hosting domain is actually a FreeBSD.org domain, so
 * we don't accidentally obtain data from mirrors.
 */
var fbsdregex=/(docs|security|svnweb|wiki|www)\.freebsd\.org/i;
if (fbsdregex.test(h)) {
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-22767463-1']);
	_gaq.push(['_setDomainName', 'freebsd.org']);
	_gaq.push(['_setAllowHash', false]);
	/*
	 * If we ever want to track sites other than FreeBSD.org,
	 * uncomment the next line.
	 */
	//_gaq.push(['_setAllowLinker', true]);
	// This is what we track
	_gaq.push(['_trackPageview']);
	_gaq.push(['_trackPageLoadTime']);
	_gaq.push(['_setCustomVar',
		/*
		 * This is the last available 'slot', and can be adjusted
		 * if needed; 1 through 5 are available, so we can add more
		 * custom variables if needed.
		 */
		5,
		/*
		 * This is the custom name to what this custom variable
		 * will be reported as.
		 */
		'Real Operating System',
		/*
		 * Try to track what operating systems are used to visit
		 * the site.
		 */
		navigator.platform,
		/*
		 * Tracking is done per cookie to try to identify unique
		 * visitors.
		 */
		1
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

