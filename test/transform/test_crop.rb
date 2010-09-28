require 'helper'

module TieDye
  describe "Crop" do
    it "crops an image" do
      path = File.expand_path("../../samples/wagon.jpg", __FILE__)
      image = Image.read path
      c = image.crop(10, 20, 120, 130)
      im = c.run

      assert_equal 120, im.x_size
      assert_equal 130, im.y_size

      pix = c.run[52, 60]
      pix2 = image.run[62, 80]

      assert_equal pix, pix2
    end
  end
end
