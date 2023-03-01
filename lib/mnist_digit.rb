
class MnistDigit

    def initialize(label, pixels)
      @label = label
      @pixels = pixels
    end
  
    def label 
      @label
    end
  
    def pixels
      @pixels
    end
  
    def ascii_image
      img = ""
      pixels.each_with_index do |value, index|
        img += "\n" if index > 0 and index % 28 == 0
        img += gray(value)
      end
      img_array = img.split("\n")
      new_img_array = []
      found = false
      img_array.each do |line|
        next if !found and line.strip.empty?
        found = true
        new_img_array.push(line)
      end
      found = false
      new_img_array2 = []
      new_img_array.reverse.each do |line|
        next if !found and line.strip.empty?
        found = true
        new_img_array2.push(line)
      end
  
      img =  " ____________________________ \n"
      img += "|            #{label}               |\n"
  
      img += "|----------------------------|\n"
      img += "|                            |\n"
  
      new_img_array2.reverse.each do |line|
        img += "|#{line}|\n"
      end
  
      img += "|____________________________|\n"
  
    end
  
    def pixel_image(no_zeros = false)
      img =  " _________________________________________________________________________________________________________________ \n"
      img += "|                                                  #{label}                                                              |\n"
      img += "|-----------------------------------------------------------------------------------------------------------------|\n"
  
      pixels.each_slice(28).to_a.each do |array|
        img += "| %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d |\n" % array
      end
  
      img +=  "|_________________________________________________________________________________________________________________|\n"
  
      if not no_zeros
        img
      else
        img.gsub(/ 0 /, "   ")
      end
    end
    
    private
  
    # http://paulbourke.net/dataformats/asciiart/
    @@grayScale = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\" ^`'. "
  
    def gray(value)
      value = 255 - value
      index = (@@grayScale.length / 255.0 * (value)).round - 1
      index = 0 if index < 0
      @@grayScale[index]
    end
  
  end
