require 'helper'

module TieDye
  describe "Color" do
    it "converts 8-bit SRGB to floating point SRGB" do
      srgb = Color::SRGB.new 123, 234, 12
      srgb_f = srgb.send :to_float

      assert_equal 123/255.0, srgb_f.r
      assert_equal 234/255.0, srgb_f.g
      assert_equal 12/255.0, srgb_f.b
    end

    it "converts floating point SRGB back to 8-bit" do
      srgb_f = Color::SRGBFloat.new 0.01, 0.2, 0.9
      srgb = srgb_f.to_srgb
      srgb_f2 = srgb.send :to_float

      assert_equal (255 * 0.01).round, srgb.r
      assert_equal (255 * 0.2 ).round, srgb.g
      assert_equal (255 * 0.9 ).round, srgb.b

      assert_in_delta srgb_f.r, srgb_f2.r, 0.01
      assert_in_delta srgb_f.g, srgb_f2.g, 0.01
      assert_in_delta srgb_f.b, srgb_f2.b, 0.01
    end

    it "converts floating point SRGB to linear SRGB" do
      srgb_f = Color::SRGBFloat.new 0.01, 0.2, 0.9
      srgb_l = srgb_f.send :to_linear

      assert_in_delta 0.00077, srgb_l.r
      assert_in_delta 0.03310, srgb_l.g
      assert_in_delta 0.78741, srgb_l.b
    end

    it "converts linear SRGB back to floating point SRGB" do
      srgb_l = Color::SRGBLinear.new 0.01, 0.2, 0.9
      srgb_f = srgb_l.send :to_float
      srgb_l2 = srgb_f.send :to_linear

      assert_in_delta srgb_l.r, srgb_l2.r
      assert_in_delta srgb_l.g, srgb_l2.g
      assert_in_delta srgb_l.b, srgb_l2.b
    end

    it "converts linear SRGB to XYZ" do
      srgb_l = Color::SRGBLinear.new 0.01, 0.2, 0.9
      xyz = srgb_l.to_xyz

      assert_in_delta 0.2380, xyz.x
      assert_in_delta 0.2101, xyz.y
      assert_in_delta 0.8794, xyz.z
    end

    it "converts XYZ back to linear SRGB" do
      xyz = Color::XYZ.new 0.01, 0.2, 0.9
      xyz2 = xyz.send(:to_srgb_linear).to_xyz

      assert_in_delta xyz.x, xyz2.x
      assert_in_delta xyz.y, xyz2.y
      assert_in_delta xyz.z, xyz2.z
    end

    it "converts XYZ to Lab" do
      xyz = Color::XYZ.new 0.01, 0.2, 0.9
      lab = xyz.to_lab

      assert_in_delta   51.83, lab.l, 0.1
      assert_in_delta -182.84, lab.a, 0.1
      assert_in_delta  -70.72, lab.b, 0.1
    end

    it "converts Lab back to XYZ" do
      lab = Color::Lab.new 0.01, 0.2, 0.9
      lab2 = lab.to_xyz.to_lab

      assert_in_delta lab.l, lab2.l
      assert_in_delta lab.a, lab2.a
      assert_in_delta lab.b, lab2.b
    end

    it "converts RGB to Lab and back" do
      rgb = Color::SRGB.new 0, 1, 255
      rgb2 = rgb.to_lab.to_srgb

      assert_equal rgb, rgb2

      rgb = Color::SRGB.new 255, 255, 255
      rgb2 = rgb.to_lab.to_srgb

      assert_equal rgb, rgb2
    end
  end
end
