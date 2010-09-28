require 'helper'

module TieDye
  module IO
    describe "JPEGWriter" do
      before do
        color = Color::SRGB.new 123, 123, 123
        @solid = Generate::Solid.new color, 123, 223
        @j = @solid.jpeg
      end

      it "creates a jpeg file writer" do
        assert_kind_of JPEGWriter, @j
      end

      it "writes a jpeg file" do
        path = File.join Dir::tmpdir, 'tiedye_jpeg_test.jpg'

        @j.write path
        assert File.exists?(path)

        j2 = Image.jpeg path

        assert_equal @j.run.x_size, j2.run.x_size
      end
    end
  end
end
