module TieDye
  module Transform
    class Greyscale
      include Image

      def initialize(source)
        @source = source
      end

      def run
        im = @source.run
        if im.bands == 3
          im = im.srgb_to_xyz.xyz_to_lab
          im = im.lin [1, 0, 0], [0, 0, 0]
          im.lab_to_xyz.xyz_to_srgb
        else
          im
        end
      end
    end
  end
end
