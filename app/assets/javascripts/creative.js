/*!
* Creative v1.0.4 (http://startbootstrap.com/template-overviews/creative)
* Copyright 2013-2016 Start Bootstrap
* Licensed under MIT
* https://github.com/BlackrockDigital/startbootstrap/blob/gh-pages/LICENSE
*/
(function($) {
"use strict";

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a:not(.dropdown-toggle)').click(function() {
  $('.navbar-toggle:visible').click();
});

// Fit Text Plugin for Main Header
$("h1").fitText(1.2, { minFontSize: '35px', maxFontSize: '65px' });

// Offset for Main Navigation
$('#mainNav').affix({ offset: { top: 100 }})
})(jQuery);