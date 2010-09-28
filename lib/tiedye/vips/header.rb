require 'vips'

module VIPS
  module Header
    def fit_ratio(width, height)
      width_ratio = width / x_size.to_f
      height_ratio = height / y_size.to_f
      [width_ratio, height_ratio].min
    end
  end
end
