/*
BSD 2-Clause License

Copyright (c) 1994-2025, The FreeBSD Documentation Project
Copyright (c) 2021-2025, Sergio Carlavilla
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

;(function () {
  'use strict'

  var theme = localStorage.getItem('theme');
  var themeChooser = document.querySelector('#theme-chooser');
  var themeContainer = document.querySelector('.theme-container');
  themeContainer.style.display = "block";

  if (theme === "theme-dark") {
    setTheme('theme-dark');
    themeChooser.value = 'theme-dark';
  } else if (theme === "theme-high-contrast") {
    setTheme('theme-high-contrast');
    themeChooser.value = 'theme-high-contrast';
  } else if (theme === "theme-light") {
    setTheme('theme-light');
    themeChooser.value = 'theme-light';
  } else {
    setTheme('theme-system');
    themeChooser.value = 'theme-system';
  }

  themeChooser.addEventListener('change', function() {
    var theme = this.value;

    if (theme === "theme-dark") {
      setTheme('theme-dark');
    } else if (theme === "theme-high-contrast") {
      setTheme('theme-high-contrast');
    } else if (theme === "theme-light") {
      setTheme('theme-light');
    } else {
      setTheme('theme-system');
    }
  });

  function setTheme(themeName) {
    localStorage.setItem('theme', themeName);

    if (themeName === 'theme-system') {
      if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        document.documentElement.className = 'theme-dark';
      } else {
        document.documentElement.className = 'theme-light';
      }
    } else {
      document.documentElement.className = themeName;
    }
  }
})();
