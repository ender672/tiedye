require 'vips'

module TieDye
  module Transform
    class Sharpen
      include Image

      SHARPEN_MASK = begin
        conv_mask = [
          [ -1, -1, -1 ],
          [ -1, 16, -1 ],
          [ -1, -1, -1 ]
        ]
        VIPS::Mask.new conv_mask, 8
      end

      def initialize(source)
        @source = source
      end

      def run
        @source.run.conv SHARPEN_MASK
      end
    end
  end
end
