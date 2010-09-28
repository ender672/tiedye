module TieDye
  module Transform
    class Fit
      include Image

      def initialize(source, width, height)
        @source, @width, @height = source, width, height
      end

      def run
        data = @source.run
        r = data.fit_ratio @width, @height

        if r > 1
          data.affinei_resize :nearest, r
        elsif r < 1
          if r <= 0.5
            data = data.shrink((1/r).floor)
            r = data.fit_ratio @width, @height
          end
          data = data.affinei_resize :bilinear, r if r < 1

          Sharpen.transform data
        else
          data
        end
      end
    end
  end
end