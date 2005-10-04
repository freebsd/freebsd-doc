/* http://www.alistapart.com/articles/alternate/ */

var is_khtml = /Konqueror|Safari|KHTML/i.test(navigator.userAgent);
var is_safari = /Safari/i.test(navigator.userAgent);
var is_konq = is_khtml&&!is_safari;

function
setActiveStyleSheet (title)
{
  var i, a, main;
  for (i = 0; (a = document.getElementsByTagName ("link")[i]); i++)
    {
      if (a.getAttribute ("rel").indexOf ("style") != -1
	  && a.getAttribute ("title"))
	{
	  a.disabled = true;
	  if (a.getAttribute ("title").indexOf(title) != -1)
	    a.disabled = false;
	}
    }
}

function
getActiveStyleSheet ()
{
  var i, a;
  for (i = 0; (a = document.getElementsByTagName ("link")[i]); i++)
    {
      if (a.getAttribute ("rel").indexOf ("style") != -1
	  && a.getAttribute ("title") && !a.disabled)
	return a.getAttribute ("title");
    }
  return null;
}

function
getPreferredStyleSheet ()
{
  var i, a;
  for (i = 0; (a = document.getElementsByTagName ("link")[i]); i++)
    {
      if (a.getAttribute ("rel").indexOf ("style") != -1
	  && a.getAttribute ("rel").indexOf ("alt") == -1
	  && a.getAttribute ("title"))
	return a.getAttribute ("title");
    }
  return null;
}

function
createCookie (name, value, days)
{
  if (days)
    {
      var date = new Date ();
      date.setTime (date.getTime () + (days * 24 * 60 * 60 * 1000));
      var expires = "; expires=" + date.toGMTString ();
    }
  else
    expires = "";
  document.cookie = name + "=" + value + expires + "; path=/";
}

function
readCookie (name)
{
  var nameEQ = name + "=";
  var ca = document.cookie.split (';');
  for (var i = 0; i < ca.length; i++)
    {
      var c = ca[i];
      while (c.charAt (0) == ' ')
	c = c.substring (1, c.length);
      if (c.indexOf (nameEQ) == 0)
	return c.substring (nameEQ.length, c.length);
    }
  return null;
}

window.onload = function (e)
{
  if (is_konq) {
    document.getElementById("searchnavlist").getElementsByTagName("li")[0].style.display = 'none';
    return;
  }
  var cookie = readCookie ("style");
  var title = cookie ? cookie : getPreferredStyleSheet ();
  setActiveStyleSheet (title);
}

window.onunload = function (e)
{
  if (is_konq) {
    return;
  }
  var title = getActiveStyleSheet ();
  createCookie ("style", title, 365);
}

/* Stylesheet switching does not work in Konqueror */
if (!is_konq) {
	var cookie = readCookie ("style");
	var title = cookie ? cookie : getPreferredStyleSheet ();
	setActiveStyleSheet (title);
}