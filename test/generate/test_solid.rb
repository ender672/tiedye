require 'helper'

module TieDye
  module Generate
    describe "Solid" do
      it "generates a red image" do
        red = Color::SRGB.new 255, 0, 0
        solid = Solid.new red, 123, 345
        im = solid.run

        assert_equal 123, im.x_size
        assert_equal 345, im.y_size

        assert_equal [255, 0, 0], im[23, 52]
      end
    end
  end
end
