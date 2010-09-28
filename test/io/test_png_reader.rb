require 'helper'

module TieDye
  module IO
    describe "PNGReader" do
      before do
        @path = File.expand_path("../../samples/bg.png", __FILE__)
        @width = 700
        @p = PNGReader.new(@path)
      end

      it "reads a png file" do
        png = @p.run
        assert_kind_of VIPS::Image, png
        assert_equal png.x_size, @width
      end
    end
  end
end
