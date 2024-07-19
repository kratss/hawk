#!/usr/bin/env fish

set mime $(file --mime-type $argv)
set name $(basename $argv)
#set -l exif_trait $(exiftool "$argv" | grep -e "Artist" -e "Album" -e "Artist" )
#echo $exif_trait
#set exif_trait $(string replace -r "Album" "" $exif_trait)
#set exif_trait $(string replace -r "Artist" "" $exif_trait)
#set exif_trait $(string replace -r "Title" "" $exif_trait)
#set exif_trait $(string replace -r ":" "" $exif_trait)
#set exif_trait $(string trim $exif_trait)

set exif_data $(exiftool $argv)


function substring
    string match --regex --quiet $argv $mime
end 

function print_exif
    set count
    set -g exif_trait
    for i in $argv
        set count $(math $count + 1) 
        set -a exif_trait $(string match -e $i $exif_data)
        set exif_trait $(string replace -a -r $i '' $exif_trait)
        set exif_trait $(string replace -r ':' '' $exif_trait)
        set exif_trait $(string trim $exif_trait)
        set -a exif_trait "\n"
    end
end

if substring 'application/vnd.oasis.opendocument'
    echo -e "$name\n\n"
else if  substring 'pdf'
    echo -e "$name\n\n"
    pdftotext -l 2 $argv -
else if substring 'video' 
    echo -e "⏯️ $name\nvideo\n"
    print_exif $exif_trait 'Artist'
else if substring 'audio' 
    echo "🎜  $name"
    print_exif Artist Album Title
    printf "$exif_trait"
else if substring 'image'
    echo "🖻 $name"
    if test $(command -v chafa)
        chafa $argv -s 300x500 --polite=false
    end
else if substring 'directory'
    echo -e "$name\nFolder\n\n"
else if substring 'text'
    echo -e "$name\n\n"
    cat $argv
end
