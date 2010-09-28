require 'helper'

module TieDye
  describe "Colorize" do
    before do
      path = File.expand_path("../../samples/wagon.jpg", __FILE__)
      @image = Image.read path
      @colorized = Transform::Colorize.new @image, 12, 244, 100
    end

    it "doesn't modify image dimensions" do
      im = @image.run
      c = @colorized.run

      assert_equal im.x_size, c.x_size
      assert_equal im.y_size, c.y_size
    end

    it "changes colors" do
      im = @image.run
      c = @colorized.run

      refute_equal im[0, 0], c[0, 0]
      refute_equal im[120, 120], c[120, 120]
    end

    it "maintains greyscale" do
      colorized = Transform::Colorize.new @image, 100, 100, 100
      c = colorized.run
      pixel = c[100, 120]

      assert_equal pixel[0], pixel[1]
      assert_equal pixel[0], pixel[2]
    end
  end
end
