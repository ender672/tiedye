require 'helper'

module VIPS
  describe "getting the fit ratio" do
    before do
      @im = Image.black 200, 200, 3
    end

    it "gets the ratio when determined by width" do
      assert_equal @im.fit_ratio(100, 150), 0.5
    end

    it "gets the ratio when determined by height" do
      assert_equal @im.fit_ratio(100, 50), 0.25
    end
  end
end
