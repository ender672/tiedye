require 'helper'

module TieDye
  describe "Greyscale" do
    it "turns an image to greyscale" do
      path = File.expand_path("../../samples/wagon.jpg", __FILE__)
      gs = Image.read(path).greyscale.run
      pixel = gs[100, 120]

      assert_equal pixel[0], pixel[1]
      assert_equal pixel[0], pixel[2]
    end
  end
end
