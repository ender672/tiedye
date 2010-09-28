require 'helper'

module TieDye
  module Generate
    describe "Gradient" do
      it "creates an SRGB identity" do
        c1 = Color::SRGB.new 0, 0, 0
        c2 = Color::SRGB::WHITE

        g = Gradient.new c1, c2, 256
        im = g.run

        assert_equal [  0,   0,   0], im[  0, 0]
        assert_equal [128, 128, 128], im[128, 0]
        assert_equal [255, 255, 255], im[255, 0]
      end

      it "creates a Lab identity" do
        c1 = Color::Lab.new 0, 0, 0
        c2 = Color::Lab::WHITE

        g = Gradient.new c1, c2, 256
        im = g.run

        assert_equal [  0, 0, 0], im[  0, 0]
        assert_equal [100, 0, 0], im[255, 0]
      end

      it "creates a luminance-augmented gradient in Lab" do
        c1 = Color::Lab.new 25, -1, -55
        c2 = Color::Lab.new 75, 15, 60

        g = LumLabGradient.new c1, c2, 1000
        im = g.run

        assert_equal [  0, -1, -55], im[  0, 0]
        assert_equal [100, 15,  60], im[999, 0]
      end

      it "creates a luminance-augmented gradient in SRGB" do
        c1 = Color::Lab.new 25, -1, -55
        c2 = Color::Lab::WHITE

        g = LumSRGBGradient.new c1, c2, 1000
        im = g.run

        assert_equal [255, 255, 255], im[999, 0]
      end
    end
  end
end
