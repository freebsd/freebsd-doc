" formatting SGML documents
" $FreeBSD$

if !exists("format_fdp_sgml")
  let format_fdp_sgml = 1
  " correction for highlighting special characters
  autocmd BufNewFile,BufRead *.sgml,*.ent,*.html syn match sgmlSpecial "&[^;]*;"

  " formatting FreeBSD SGML/Docbook
  autocmd BufNewFile,BufRead *.sgml,*.ent set autoindent formatoptions=tcq2l textwidth=70 shiftwidth=2 softtabstop=2 tabstop=8
endif
