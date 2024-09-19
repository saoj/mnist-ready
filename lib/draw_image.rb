require 'rmagick'
require 'base64'

class DrawImage

    def self.draw(pixel_array, white_background = false)

        # Create a new 28x28 image
        image = Magick::Image.new(28, 28)

        # Set each pixel in the image
        28.times do |y|
            28.times do |x|
                pixel_value = pixel_array[y * 28 + x]
                pixel_value = 255 - pixel_value if white_background
                color = Magick::Pixel.new(pixel_value * 257, pixel_value * 257, pixel_value * 257)
                image.pixel_color(x, y, color)
            end
        end

        # Scale up the image to make it more visible
        image = image.scale(10)

        # Set the format to PNG
        image.format = 'PNG'

        # Convert the image to a blob
        blob = image.to_blob

        # Encode the blob as base64
        encoded_image = Base64.strict_encode64(blob)

        # Display the image inline using iTerm2's imgcat escape sequence
        puts "\033]1337;File=inline=1;size=#{blob.size}:#{encoded_image}\007"
        
        # Force a newline after the image
        puts "\n"

    end

end
