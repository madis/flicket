require 'mini_magick'
require 'flicket/layout_calculator'

module Flicket
  class CollageMaker
    attr_reader :layout

    def initialize(layout=LayoutCalculator.new)
      @layout = layout
    end

    def call(image_paths)
      images = image_paths.map { |p| MiniMagick::Image.open p.path }
      min_height = images.min_by(&:height).height
      min_width = images.min_by(&:width).width
      canvas_tempfile = Tempfile.new ['collage_maker', '.png']
      canvas = create_new_image(path: canvas_tempfile.path)

      resized_images = image_paths.map.with_index do |path, idx|
        image = MiniMagick::Image.open path.path
        image.crop(layout.crop_rect(idx, image.width, image.height).to_minimagick)
        image.resize(layout.resize_rect(idx, image.width, image.height).to_minimagick)

        add_image_to_canvas(image, layout.cell_rect(idx), canvas_tempfile)
      end
      canvas_tempfile
    end

    private

    def add_image_to_canvas(image, rect, canvas_tempfile)
      canvas = MiniMagick::Image.new canvas_tempfile.path
      result = canvas.composite(image) do |c|
        puts "Adding image to collage #{image}"
        c.compose 'Over'
        c.geometry rect.to_minimagick
      end
      result.write canvas_tempfile.path
      canvas_tempfile.rewind
    end

    def create_new_image(width:layout.width, height:layout.height, path:)
      MiniMagick::Tool::Convert.new do |i|
        i.size "#{width}x#{height}"
        i.xc "white"
        i << path
      end
    end
  end
end
