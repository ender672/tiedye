require 'helper'

module TieDye
  describe "Sharpen" do
    it "preserves the size of an image" do
      path = File.expand_path("../../samples/wagon.jpg", __FILE__)
      im = Image.read path
      s = im.sharpen

      assert_equal im.run.x_size, s.run.x_size
    end
  end
end
