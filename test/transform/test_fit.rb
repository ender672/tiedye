require 'helper'

module TieDye
  describe "Fit" do
    before do
      path = File.expand_path("../../samples/wagon.jpg", __FILE__)
      @image = Image.read path
    end

    it "grows an image into a box that is larger than it is" do
      fit = @image.fit 800, 800
      f = fit.run
      assert_equal 800, f.x_size
    end

    it "shrinks an image into a box that is smaller than it is" do
      fit = @image.fit 50, 50
      f = fit.run
      assert_equal 50, f.x_size
    end

    it "does nothing to an image when the box matches its size" do
      im = @image.run
      fit = @image.fit im.x_size, im.y_size
      assert_equal im.x_size, fit.run.x_size
    end
  end
end
