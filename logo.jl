using Luxor
using Colors

function create_logo(text_logo::String, font_family::String; name::Union{String,Symbol} = :svg, width::Int=1250, height::Int=800)

    Drawing(width, height, name)
    
    background("transparent")
    origin()
    fontsize(300)                             # big fontsize to use for clipping
    fontface(font_family)
    w, h = textextents(text_logo)[3:4]  
    
    translate(-(width / 2) + 50, -(height / 2) + 1.1h)
    
    textpath(text_logo)                             # make text into a path
    setline(10)                          # fill but keep
    clip()                                    # and use for clipping region
    
    
    fontface("Monaco")
    fontsize(8)
    namelist = map(x -> string(x), names(Base)) # get list of function names in Base.

    let
        x = -20
        y = -h
        while y < height
            sethue(rand(7:10) / 10, rand(7:10) / 10, rand(7:10) / 10)
            s = namelist[rand(1:end)]
            text(s, x, y)
            se = textextents(s)
            x += se[5]                            # move to the right
            if x > w
                x = -20                            # next row
                y += 10
            end
        end
    end

    finish()
    preview()
end

file_name = "assets/output.svg"
logo = "TEST"
font_family = "MathJax_Script"
create_logo(logo, font_family)
create_logo(logo, font_family, name = file_name)

create_logo("MB", "MathJax_Script")
create_logo("MB", "MathJax_Script", name = "assets/mb.svg", height = 300, width = 800)

# Create M and B in separate files
files = ["M", "B"]
for letter in files
    create_logo("assets/tmp/$(letter).svg", letter, font_family, width=500, height=300)
end

# Join them with a separation
function join_images(files)
    Drawing(1000, 300, :svg)
    origin()
    image = readsvg("assets/tmp/$(files[1]).svg")
    for (index, file) in enumerate(files[2:end])
        println("Current letter: ", file)
        img = readsvg("assets/tmp/$(file).svg")

        w = img.width
        h = img.height

        placeimage(image, O)
        # setmode("saturate")
        # translate(300, 0)
    # placeimage(img, -w / 2, -h / 2, .5)
    end
    finish()
    preview()
end

join_images(files)