module TieDye
  class Wrapper
    include Image

    def initialize(im)
      @im = im
    end

    def run
      @im
    end
  end
end
