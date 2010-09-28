module TieDye
  module Generate
    class Gradient
      include Image

      def initialize(a, b, width)
        @a, @b, @width = a, b, width
        @diff = @b - @a
      end

      def run
        channels = @a.to_a.map{ |i| [] }

        each_color do |c|
          c.to_a.each_with_index do |d, i|
            channels[i] << d
          end
        end

        im = VIPS::Mask.new([channels[0]]).to_image
        channels[1..-1].each do |channel|
          im = im.bandjoin VIPS::Mask.new([channel]).to_image
        end

        im
      end

      def color_at_percentage(pct)
        @diff * pct + @a
      end

      def each_color
        max = @width - 1
        (0..max).each{ |i| yield color_at_percentage(i/max.to_f) }
      end
    end

    class LumLabGradient < Gradient
      def initialize(a, b, width)
        a.l > b.l ? (@max, @min = a, b) : (@max, @min = b, a)
        super a, b, width
      end

      def color_at_percentage(pct)
        l = pct * 100

        ab = if l > @max.l
          @max
        elsif l < @min.l
          @min
        else
          _pct = (l - @min.l) / (@max.l - @min.l)
          super _pct
        end

        Color::Lab.new l, ab.a, ab.b
      end
    end

    # I want the gradient to end with perfect white, i.e. SRGB 255, 255, 255.
    # However, when generating a gradient with LumLabGradient and then
    # converting to SRGB via VIPS (lab_to_xyz, xyz_to_srgb) I get imperfect
    # white -- for Lab [100, 0, 0] I get SRGB [255, 255, 254]. So for now this
    # class is here to do the conversion using our internal color conversion
    # methods.
    class LumSRGBGradient < LumLabGradient
      def color_at_percentage(pct)
        c = super pct
        c.to_srgb
      end
    end
  end
end
