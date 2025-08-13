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

  document.querySelectorAll(".rouge, .highlight").forEach(function(codeItem) {
    var sourceCode = codeItem.textContent;

    var icon = document.createElement("i");
    icon.className = "fa fa-clipboard";

    var tooltip = document.createElement("span");
    tooltip.className = "tooltip";
    tooltip.innerHTML = "Copied!";

    var button = document.createElement("button");
    button.title = "Copy to clipboard";
    button.appendChild(icon);
    button.appendChild(tooltip);

    var clipboardWrapper = document.createElement("div");
    clipboardWrapper.className = "copy-to-clipboard-wrapper";
    clipboardWrapper.appendChild(button);

    codeItem.appendChild(clipboardWrapper);

    button.addEventListener('click', copyToClipboard.bind(button, sourceCode));
  });

  function copyToClipboard(text, item) {
    const tooltip = item.target.nextElementSibling;
    window.navigator.clipboard.writeText(text).then(function() {
      if (tooltip) {
        tooltip.classList.add("show-tooltip");
        setTimeout(function(){
          tooltip.classList.remove("show-tooltip");
        }, 1200);
      }
    });
  }

})();
