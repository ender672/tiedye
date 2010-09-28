require 'matrix'

module TieDye
  module Color
    class Base
      def ==(other)
        raise ArgumentError unless other.kind_of? self.class
        to_a == other.to_a
      end

      def +(other)
        self.class.new *(to_v + other.to_v).to_a
      end

      def -(other)
        self.class.new *(to_v - other.to_v).to_a
      end

      def *(scalar)
        self.class.new *(to_v * scalar).to_a
      end

      def to_v
        Vector[*to_a]
      end
    end


    class RGB < Base
      attr_reader :r, :g, :b

      def initialize(r, g, b)
        @r, @g, @b = r, g, b
      end

      def to_s
        "r: #{@r} g: #{@g} b: #{@b}"
      end

      def to_a
        [@r, @g, @b]
      end

      def to_lab
        to_xyz.to_lab
      end
    end

    class SRGB < RGB
      def to_xyz
        to_float.to_xyz
      end

      private

      def to_float
        SRGBFloat.new *to_a.map{ |c| c_to_f c }
      end

      def c_to_f(c)
        c / 255.0
      end
    end

    SRGB::WHITE = SRGB.new 255, 255, 255

    class SRGBFloat < RGB
      def to_srgb
        SRGB.new *to_a.map{ |c| c_to_8 c }
      end

      def to_xyz
        to_linear.to_xyz
      end

      private

      def to_linear
        SRGBLinear.new *to_a.map{ |c| c_to_l c }
      end

      def c_to_l(c)
        a = 0.055

        if c <= 0.04045
          c / 12.92
        else
          ( ( c + a ) / ( 1 + a ) ) ** 2.4
        end
      end

      def c_to_8(c)
        (c.to_f * 255).round
      end
    end

    class SRGBLinear < RGB
      SRGB_XYZ_TRANSLATE = Matrix[
        [ 0.4124, 0.3576, 0.1805 ],
        [ 0.2126, 0.7152, 0.0722 ],
        [ 0.0193, 0.1192, 0.9505 ]
      ]

      def to_xyz
        xyz = SRGB_XYZ_TRANSLATE * Matrix.column_vector(to_a)
        XYZ.new *xyz.transpose.to_a[0]
      end

      def to_srgb
        to_float.to_srgb
      end

      private

      def to_float
        SRGBFloat.new *to_a.map{ |c| c_to_f c }
      end

      def c_to_f(c)
        a = 0.055

        if c > 0.0031308
          (1 + a) * c ** (1/2.4) - a
        else
         c * 12.92
        end
      end
    end

    class XYZ < Base
      XYZ_SRGB_TRANSLATE = SRGBLinear::SRGB_XYZ_TRANSLATE.inverse

      attr_reader :x, :y, :z

      X_D65 = 0.9504
      Y_D65 = 1.0
      Z_D65 = 1.0888

      def initialize(x, y, z)
        @x, @y, @z = x, y, z
      end

      def to_lab
        f_x = f(@x / X_D65)
        f_y = f(@y / Y_D65)
        f_z = f(@z / Z_D65)

        l = 116 * f_y - 16
        a = 500 * ( f_x - f_y )
        b = 200 * ( f_y - f_z )

        Lab.new l, a, b
      end

      def to_srgb
        to_srgb_linear.to_srgb
      end

      def to_a
        [@x, @y, @z]
      end

      private

      def to_srgb_linear
        srgb_l = XYZ_SRGB_TRANSLATE * Matrix.column_vector(to_a)
        SRGBLinear.new *srgb_l.transpose.to_a[0]
      end

      def f(t)
        if t > 0.008856
          t ** ( 1 / 3.0 )
        else
          7.787 * t + ( 4 / 29.0 )
        end
      end
    end

    class Lab < Base
      attr_reader :l, :a, :b

      def initialize(l, a, b)
        @l, @a, @b = l, a, b
      end

      def to_xyz
        f_y = ( @l + 16 ) / 116
        f_x = f_y + @a / 500
        f_z = f_y - @b / 200

        x = f(f_x) * XYZ::X_D65
        y = f(f_y) * XYZ::Y_D65
        z = f(f_z) * XYZ::Z_D65

        XYZ.new x, y, z
      end

      def to_srgb
        to_xyz.to_srgb
      end

      def max_lum
        self.class.new 100.0, @a, @b
      end

      def to_s
        "L: #{@l} a: #{@a} b: #{@b}"
      end

      def to_a
        [@l, @a, @b]
      end

      private

      def f(t)
        if t > 0.206897
          t ** 3
        else
          0.128419 * ( t - 0.13793 )
        end
      end
    end

    Lab::WHITE = Lab.new 100.0, 0.0, 0.0
  end
end
