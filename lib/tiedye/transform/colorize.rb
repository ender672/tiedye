module TieDye
  module Transform
    class Colorize
      include Image

      def initialize(source, r, g, b)
        @source = source
        @color = Color::SRGB.new(r, g, b).to_lab
      end

      def run
        gradient = Generate::LumSRGBGradient.new @color, Color::Lab::WHITE, 256
        @source.greyscale.run.scale.maplut gradient.run
      end
    end
  end
end
