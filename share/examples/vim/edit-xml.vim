" formatting XML documents
" $FreeBSD$

if !exists("format_fdp_xml")
  let format_fdp_xml = 1
  " correction for highlighting special characters
  autocmd BufNewFile,BufRead *.xml,*.ent,*.html syn match xmlSpecial "&[^;]*;"

  " formatting FreeBSD XML/Docbook
  autocmd BufNewFile,BufRead *.xml,*.ent set autoindent formatoptions=tcq2l textwidth=70 shiftwidth=2 softtabstop=2 tabstop=8
endif
