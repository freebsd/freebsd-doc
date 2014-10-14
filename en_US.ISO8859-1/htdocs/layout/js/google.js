/* $FreeBSD$ */

/*
 * Please do not commit to this file without receiving review from
 * webstats@FreeBSD.org.
 */

/* Teach jslint the appropriate style rules. */
/*jslint browser:true*/

var enable_ga = true;
var allow_track = true;

var h = document.location.hostname;
/*
 * Check that the hosting domain is actually a FreeBSD.org domain, so
 * we don't accidentally obtain data from mirrors.
 */
var fbsdregex = /((docs|security|svnweb|wiki|www)\.freebsd\.org|google\.com)$/i;

if (typeof navigator.doNotTrack !== "undefined" && (navigator.doNotTrack == "yes" || navigator.doNotTrack == "1")) {
	allow_track = false;
}

if (enable_ga && allow_track && fbsdregex.test(h)) {
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-22767463-1']);
	_gaq.push(['_setDomainName', 'freebsd.org']);
	_gaq.push(['_setAllowHash', false]);
	_gaq.push (['_gat._anonymizeIp']);

	/*
	 * If we ever want to track sites other than FreeBSD.org,
	 * uncomment the next line.
	 */
	//_gaq.push(['_setAllowLinker', true]);
	// This is what we track
	_gaq.push(['_trackPageview']);
	_gaq.push(['_trackPageLoadTime']);

	( function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = 'https://ssl.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);

	})();

}

