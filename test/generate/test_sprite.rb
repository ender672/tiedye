require 'helper'

module TieDye
  describe "Sprite" do
    before do
      @path1 = File.expand_path("../../samples/wagon.jpg", __FILE__)
      @path2 = File.expand_path("../../samples/bg.png", __FILE__)

      @im1 = Image.read(@path1).run
      @im2 = Image.read(@path2).run

      @sprite = Image.sprite @path1, @path2
      @im_s = @sprite.run
    end

    it "grows the result image when composing a sprite image" do
      assert_equal @im1.y_size + @im2.y_size, @im_s.y_size

      max = [@im1.x_size, @im2.x_size].max
      assert_equal max, @im_s.x_size
    end

    it "preserves pixels when compising a sprite image" do
      assert_equal @im1[0, 0], @im_s[0, 0]
      assert_equal @im1[20, 20], @im_s[20, 20]

      assert_equal @im2[10, 10], @im_s[10, @im1.y_size + 10]
    end
  end
end
