module TieDye
  module Generate
    class Solid
      include Image

      def initialize(color, width, height)
        @color, @width, @height = color, width, height
      end

      def run
        color_a = @color.to_a
        bands = color_a.size
        im = VIPS::Image.black @width, @height, bands

        m = color_a.map{ |i| 0 }
        im.lin m, color_a
      end
    end
  end
end
