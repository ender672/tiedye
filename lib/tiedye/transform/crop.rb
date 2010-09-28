module TieDye
  module Transform
    class Crop
      include Image

      def initialize(source, left, top, width, height)
        @source, @left, @top, @width, @height = source, left, top, width, height
      end

      def run
        @source.run.extract_area @left, @top, @width, @height
      end
    end
  end
end
