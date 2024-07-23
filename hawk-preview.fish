#!/usr/bin/env fish
argparse 't/thumb_size=' -- $argv
set -g _flag_thumb_size $_flag_thumb_size

set mime $(file --mime-type $argv)
set name $(basename $argv)

function print_img 
    if test (command -v chafa)
        chafa $argv --size $_flag_thumb_size 2> /dev/null 
   end
end

function get_thumbnail #print exif thumbnail as binary stream
    if string match --entire --quiet Picture $exif_data
        set exif_img_size $(string match -e Picture $exif_data | tr -dc '0-9') 
        exiftool -Picture -b $argv[1] | head -c $exif_img_size
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
    echo -e "🖹 $name\n"
    if test $(command -v odt2txt)
        printf "$(odt2txt $argv --width=30)"
    end

else if  substring 'pdf'
    echo -e "🖹 $name\n"
    if test $(command -v pdftotext)
        pdftotext -l 2 $argv -
    end 

else if substring 'video' 
    echo -e "⏯️ $name\nvideo"
    set exif_data $(exiftool $argv)
    get_exif $exif_trait Artist Title
    printf " $exif_trait"
    if test $(command -v ffmpeg)
        ffmpeg -i $argv -frames:v 1 -f image2pipe - 2> /dev/null | print_img
    end

else if substring 'audio' 
    echo "🎜  $name"
    set exif_data $(exiftool $argv)
    get_exif Artist Album Title
    printf " $exif_trait"
    get_thumbnail $argv | print_img 

else if substring 'image'
    echo "🖻 $name"
    print_img $argv

else if substring 'directory'
    echo -e "$name\nFolder\n"

else if substring 'text'
    echo -e "$name\n"
    cat $argv

end
