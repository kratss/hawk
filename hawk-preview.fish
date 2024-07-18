#!/usr/bin/env fish

set arg 
set mime $(file --mime-type $argv)
set name $(basename $argv)
function substring
    string match --regex --quiet $argv $mime
end 


if substring 'application/vnd.oasis.opendocument'
    echo -e "$name\n\n"
else if  substring 'pdf'
    echo -e "$name\n\n"
    pdftotext -l 2 $argv -
else if substring 'video' 
    echo -e "⏯️ $name\n\n"
else if substring 'audio' 
    echo -e "🎜  $name\n\n"
else if substring 'text'
    echo -e "$name\n\n"
    cat $argv 
end
