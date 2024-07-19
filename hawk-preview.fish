#!/usr/bin/env fish

set mime $(file --mime-type $argv)
set name $(basename $argv)
set exif_data $(exiftool $argv)

function print_thumbnail
    if string match --entire --quiet Picture $exif_data
        set exif_img_size $(string match -e Picture $exif_data | tr -dc '0-9') 
        exiftool -Picture -b $argv | head -c $exif_img_size | chafa --size 20x20
    end
end

function get_exif
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

function substring
    string match --regex --quiet $argv $mime
end 

if substring 'application/vnd.oasis.opendocument'
    echo -e "$name\n\n"

else if  substring 'pdf'
    echo -e "$name\n\n"
    pdftotext -l 2 $argv -

else if substring 'video' 
    echo -e "⏯️ $name\nvideo\n"
    get_exif $exif_trait 'Artist'
    printf " $exif_trait"
    ffmpeg -i $argv -frames:v 1 -f image2pipe - 2> /dev/null | chafa --size 30x30

else if substring 'audio' 
    echo "🎜  $name"
    get_exif Artist Album Title
    printf " $exif_trait"
    print_thumbnail $argv 

else if substring 'image'
    echo "🖻 $name"
    if test $(command -v chafa)
        chafa $argv --size 25x40 --polite=false
    end

else if substring 'directory'
    echo -e "$name\nFolder\n\n"

else if substring 'text'
    echo -e "$name\n\n"
    cat $argv

end
