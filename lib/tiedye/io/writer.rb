module TieDye
  module IO
    class Writer
      def initialize(source)
        @source = source
      end

      def run
        @source.run
      end

      def to_s
        run.to_memory
      end

      def write(path)
        run.write path
      end
    end

    class JPEGWriter < Writer
      def run
        @source.run.jpeg
      end
    end

    class PNGWriter < Writer
      def run
        @source.run.png
      end
    end
  end
end
