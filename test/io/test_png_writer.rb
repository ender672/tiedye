require 'helper'

module TieDye
  module IO
    describe "PNGWriter" do
      before do
        color = Color::SRGB.new 123, 123, 123
        @solid = Generate::Solid.new color, 123, 223
        @p = @solid.png
      end

      it "creates a png file writer" do
        assert_kind_of PNGWriter, @p
      end

      it "writes a png file" do
        path = File.join Dir::tmpdir, 'tiedye_png_test.png'

        @p.write path
        assert File.exists?(path)

        p2 = Image.png path

        assert_equal @p.run.x_size, p2.run.x_size
      end
    end
  end
end
