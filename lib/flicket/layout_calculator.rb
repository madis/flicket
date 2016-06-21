require 'flicket/rectangle'

module Flicket
  class LayoutCalculator
    WIDTH = 2304
    HEIGHT = 1440
    LAYOUT = [
      [0,1,2,3],
      [4,5,6,3],
      [4,7,8,9]
    ]

    def rows
      LAYOUT.size
    end

    def columns
      LAYOUT.max_by(&:length).length
    end

    def row_cells
      LAYOUT
    end

    def column_cells
      LAYOUT.transpose
    end

    def cell_width(name)
      size_multiplier = repeated_matches(LAYOUT, name)
      calculate_cell_size(WIDTH, columns, size_multiplier)
    end

    def cell_height(name)
      size_multiplier = repeated_matches(column_cells, name)
      calculate_cell_size(HEIGHT, rows, size_multiplier)
    end

    def crop_rect(cell_name, image_width, image_height)
      image = Rectangle.new(image_width, image_height)
      cell = cell_rect(cell_name)

      target_x = 0
      target_y = 0

      if image.aspect_ratio >= cell.aspect_ratio # image is wider, make it narrower
        crop_size = image.width - (image.height * cell.aspect_ratio)
        target_width = image_width - crop_size
        target_height = image.height
      else # image is narrower, cut it shorter (thus it becoming relatively wider)
        crop_size = image.height - (image.width / cell.aspect_ratio)
        target_width = image.width
        target_height = image.height - crop_size
      end

      crop_rect = Rectangle.new(target_x, target_y, target_width, target_height)
      crop_rect
    end

    def resize_rect(cell_name, image_width, image_height)
      image = Rectangle.new(image_width, image_height)
      cell_rect(cell_name)
    end

    def cell_rect(name)
      row, column = cell_coordinates(name)
      width = WIDTH / columns
      height = HEIGHT / rows

      Rectangle.new(column*width, row*height, cell_width(name), cell_height(name))
    end

    def height
      HEIGHT
    end

    def width
      WIDTH
    end

    private

    def cell_coordinates(name)
      row = LAYOUT.find_index {|row| row.include? name }
      column = LAYOUT.transpose.find_index {|row| row.include? name }
      [row, column]
    end

    def repeated_matches(table, name)
      wideness_multiplier = table.map {|row| row.count(name)}.max
    end

    def calculate_cell_size(total, divisions, multiplier)
      if multiplier == 0
        0
      else
        (total / divisions) * multiplier
      end
    end
  end
end
