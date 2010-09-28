require 'helper'

module TieDye
  module IO
    describe "JPEGReader" do
      before do
        @path = File.expand_path("../../samples/wagon.jpg", __FILE__)
        @width = 685
        @j = JPEGReader.new(@path)
      end

      it "reads a jpeg file" do
        j = @j.run
        assert_kind_of VIPS::Image, j
        assert_equal j.x_size, @width
      end

      it "pre shrinks a file when no previous pre shrink is set" do
        k = @j.fit 200, 200 # this should pre-shrink the image by a factor of 2
        assert_equal 2, k.source.shrink_factor
      end

      it "adjusts pre shrink when a smaller shrink was already set" do
        j = JPEGReader.new(@path, :shrink_factor => 2)
        k = j.fit 100, 100
        assert_equal 4, k.source.shrink_factor
      end

      it "preserves pre shrink when a larger shrink was previously set" do
        j = JPEGReader.new(@path, :shrink_factor => 8)
        k = j.fit 100, 100
        assert_equal 8, k.source.shrink_factor
      end
    end
  end
end
