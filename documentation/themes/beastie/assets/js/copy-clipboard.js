/*
BSD 2-Clause License

Copyright (c) 1994-2026, The FreeBSD Documentation Project
Copyright (c) 2021-2026, Sergio Carlavilla
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

  // "% git remote -v", "freefall% gen-gitconfig.sh": a prompt, optionally
  // prefixed by a host name, and the command it introduces.
  var PROMPT = /^([^\s#%$]{0,32})([#%$])[ \t]+(\S.*)$/

  // "#" also starts a shell comment and turns up in command output, so it
  // takes a stricter test than the unambiguous "%" and "$".
  function isCommand(text, prompt) {
    var word = /^\S+/.exec(text)
    if (!word || /[:,]$/.test(word[0])) return false
    return (prompt === '#' ? /^[a-z_.\/~\\$(]/ : /^[A-Za-z_.\/~\\$(]/).test(word[0])
  }

  // The prompts this block uses, or null when it is no session at all: a
  // Makefile, a configuration file, plain output.  "#" is a prompt only in a
  // block that opens as root or that runs su(1) part way through.
  function promptsOf(lines) {
    var found = {}, opens = null, root = false, i, match, prompt
    for (i = 0; i < lines.length; i++) {
      if (!lines[i].trim()) continue
      match = PROMPT.exec(lines[i])
      prompt = match && isCommand(match[3], match[2]) ? match[2] : null
      if (prompt) found[prompt] = true
      if (prompt === '%' || prompt === '$') root = root || /^su(do)?\b/.test(match[3])
      if (opens === null) opens = prompt || ''
    }
    if (found['%'] || found['$']) {
      return { '%': found['%'], '$': found['$'], '#': found['#'] && root }
    }
    if (found['#'] && opens === '#') return { '#': true }
    return null
  }

  // What carries the command on to the next line, if anything.  A heredoc
  // counts only once its delimiter really turns up, so that a stray "<<" in an
  // example cannot swallow the rest of the block.
  function continues(command, lines, from) {
    if (/(\\|&&|\|)$/.test(command)) return {}
    var heredoc = /<<-?[ \t]*(['"]?)([A-Za-z_][A-Za-z0-9_]*)\1/.exec(command)
    if (!heredoc) return null
    for (var i = from; i < lines.length; i++) {
      if (lines[i].trim() === heredoc[2]) return { delimiter: heredoc[2] }
    }
    return null
  }

  // Collect the commands instead of stripping the prompts, so that an
  // unrecognised line is left out rather than copied as if it were one.
  function commandsIn(text) {
    var lines = text.split('\n')
    var prompts = promptsOf(lines)
    if (!prompts) return text

    var commands = [], pending = null, i, line, match, prompted

    for (i = 0; i < lines.length; i++) {
      line = lines[i].replace(/[ \t]+$/, '')
      match = PROMPT.exec(line)
      prompted = !!match && !!prompts[match[2]] && isCommand(match[3], match[2])

      // A heredoc runs to its delimiter whatever the lines look like; any
      // other continuation ends as soon as a line carries a prompt again.
      if (pending && (pending.delimiter || !prompted)) {
        commands.push(line)
        pending = pending.delimiter
          ? (line.trim() === pending.delimiter ? null : pending)
          : continues(line, lines, i + 1)
        continue
      }

      if (prompted) {
        commands.push(match[3])
        pending = continues(match[3], lines, i + 1)
      }
    }

    return commands.join('\n')
  }

  // Asciidoctor renders a callout ("<1>") as markup inside the block, so the
  // text has to be read with those nodes taken back out.
  function textOf(block) {
    var copy = block.cloneNode(true)
    var conums = copy.querySelectorAll('.conum, .conum + b')
    for (var i = 0; i < conums.length; i++) conums[i].remove()
    return copy.textContent
  }

  document.querySelectorAll(".rouge, .highlight").forEach(function(codeItem) {
    var sourceCode = commandsIn(textOf(codeItem));

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
