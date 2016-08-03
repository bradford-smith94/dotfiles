" Bradford Smith
" 08/03/2016
" ~/.vim/ftplugin/xml.vim
" XML filetype specific configuration

"settings
setlocal omnifunc=xmlcomplete#CompleteTags

"see: vim.wikia.com/wiki/Format_your_xml_document_using_xmllint
let &l:formatprg='xmllint --format --recover -'
