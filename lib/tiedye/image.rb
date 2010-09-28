module TieDye
  module Image
    module ClassMethods
      def transform(im, *args)
        wrapper = Wrapper.new im
        new(wrapper, *args).run
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    attr_reader :source

    def self.sprite(*args)
      Generate::Sprite.new *args
    end

    def self.gradient(*args)
      Generate::Gradient.new *args
    end

    def bands
      run.bands
    end

    def fit(*args)
      Transform::Fit.new self, *args
    end

    def greyscale(*args)
      Transform::Greyscale.new self, *args
    end

    def colorize(*args)
      Transform::Colorize.new self, *args
    end

    def sharpen(*args)
      Transform::Sharpen.new self, *args
    end

    def crop(*args)
      Transform::Crop.new self, *args
    end

    def self.read(*args)
      IO::Reader.new *args
    end

    def self.jpeg(*args)
      IO::JPEGReader.new *args
    end

    def self.png(*args)
      IO::PNGReader.new *args
    end

    def jpeg
      IO::JPEGWriter.new self
    end

    def write(*args)
      IO::Writer.new(self).write(*args)
    end

    def png
      IO::PNGWriter.new self
    end
  end
end
