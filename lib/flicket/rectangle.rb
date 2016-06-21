module Flicket
  class Rectangle
    attr_reader :x, :y, :width, :height

    def initialize(x=0, y=0, width, height)
      @x = x
      @y = y
      @width = width
      @height = height
    end

    def aspect_ratio
      width.to_f / height
    end

    def landscape?(width, height)
      aspect_ratio >= 1
    end

    def portrait?(width, height)
      !landscape?
    end

    def to_minimagick
      "#{width}x#{height}+#{x}+#{y}"
    end

    def ==(o)
      o.class == self.class && o.state == state
    end

    protected

    def state
      [@x, @y, @width, @height]
    end
  end
end
