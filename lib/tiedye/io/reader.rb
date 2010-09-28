module TieDye
  module IO
    class Reader
      include Image

      attr_reader :path

      def initialize(path)
        @path = path
      end

      def run
        reader.read
      end

      private

      def reader
        @reader ||= VIPS::Reader.new(@path)
      end
    end

    class JPEGReader < Reader
      include Image

      attr_reader :shrink_factor

      def initialize(path, options={})
        @path = path
        @shrink_factor = options[:shrink_factor] || 1
      end

      # We can pre-shrink the image on load if we know that a later operation
      # will try to fit the image into a smaller rectangle.
      def fit(width, height)
        pre = pre_shrink width, height
        if pre && pre > @shrink_factor
          o = self.class.new @path, :shrink_factor => pre
          Transform::Fit.new o, width, height
        else
          super width, height
        end
      end

      private

      def pre_shrink(width, height)
        ratio = reader.fit_ratio width, height

        case (1/ratio)
        when (0...2) then nil
        when (2...4) then 2
        when (4...8) then 4
        else 8
        end
      end

      def reader
        @reader ||= VIPS::JPEGReader.new(@path, :shrink_factor => @shrink_factor)
      end
    end
    
    class PNGReader < Reader
      include Image

      private

      def reader
        @reader ||= VIPS::PNGReader.new @path
      end
    end
  end
end
