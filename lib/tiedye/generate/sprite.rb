module TieDye
  module Generate
    class Sprite
      include Image

      def initialize(*paths)
        @paths = paths
      end

      def placements
        infos = image_info

        # All sprites will be aligned left
        infos.each{ |info| info[:left] = 0 }

        infos[0][:top] = 0
        infos[1..-1].each_with_index do |info, i|
          previous_info = infos[i]
          info.merge! :top => ( previous_info[:top] + previous_info[:height] )
        end

        infos
      end

      def run
        im_black = VIPS::Image.black 1, 1, 1

        placements.inject(im_black) do |im_memo, info|
          im_memo.insert info[:im], info[:left], info[:top]
        end
      end

      private

      def images
        @images ||= @paths.map { |path| VIPS::Image.new(path) }
      end

      def image_info
        images.map{ |im| {:im => im, :width => im.x_size, :height => im.y_size} }
      end
    end
  end
end
