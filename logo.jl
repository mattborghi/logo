using Luxor
using Colors

function create_logo(name::String, text_logo::String, font_family::String; width::Int=1250, height::Int=800)

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
create_logo(file_name, logo, font_family)


# Create M and B in separate files
files = ["M", "B", "A"]
for letter in files
    create_logo("assets/tmp/$(letter).png", letter, font_family, width=500, height=300)
end

# Join them with a separation
function join_images(files)
    Drawing(1000, 300, :png)
    origin()
    image = readpng("assets/tmp/$(files[1]).png")
    for (index, file) in enumerate(files[2:end])
        println("Current letter: ", file)
        img = readpng("assets/tmp/$(file).png")

        w = img.width
        h = img.height

        placeimage(image, -w / 2, -h / 2, .5)
        # setmode("saturate")
        translate(300, 0)
    # placeimage(img, -w / 2, -h / 2, .5)
    end
    finish()
    preview()
end

join_images(files)