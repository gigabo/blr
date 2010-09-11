#!/usr/bin/env ruby

# Conway's Game of Life
#
# As an MVC learning experiment

class LifeModel
  attr_reader :width, :height
  def initialize (width=80, height=20)
    @width = width
    @height = height
    initialize_cells
  end

  def initialize_cells
    @cells = (@width * @height).times.collect do
      LifeModel::Cell.new(rand(2) == 1 ? true : false )
    end
    @cells.length.times do |i|
      x = i % width;
      y = i / width;
      above = row((y-1)%height)
      level = row(y);
      below = row((y+1)%height)
      @cells[i].neighbors = [
        above[(x-1)%width],above[x],above[(x+1)%width],
        level[(x-1)%width],         level[(x+1)%width],
        below[(x-1)%width],below[x],below[(x+1)%width],
      ]
    end
  end

  def row (i)
    @cells[i*width, width]
  end

  class LifeIsStable < Exception
  end

  def step
    before = @cells.collect { |c| c.alive }
    @cells.each { |c| c.look_around }
    @cells.each { |c| c.live_or_die }
    after = @cells.collect { |c| c.alive }
    raise LifeIsStable if before == after or @before_before == after
    @before_before = before
  end

  class Cell
    attr_reader :alive
    attr_accessor :neighbors
    def initialize (alive)
      @alive = alive
    end
    def look_around
      neighbors_alive = neighbors.inject(0){|x,n|x+=n.alive ? 1 : 0}
      @going_to_live = case neighbors_alive
        when 2; @alive
        when 3; true
        else false
      end
    end
    def live_or_die
      @alive = @going_to_live
    end
  end
end

class LifeView
  def initialize(model)
    @model = model
  end
  def display
    clear_screen
    border_top_bottom
    @model.height.times do |i|
      display_row(@model.row(i))
    end
    border_top_bottom
  end
  def clear_screen
    10.times { puts }
  end
  def border_top_bottom
    puts "+#{'-' * @model.width}+"
  end
  def display_row (row)
    puts "|#{row.collect{|cell| cell.alive ? 'X' : ' ' }}|"
  end
end

class LifeController
  def initialize(args={})
    width  = args[:width]  || 80
    height = args[:height] || 20
    @steps = args[:steps]  || 1000
    @model = LifeModel.new(width, height)
    @view = LifeView.new(@model)
  end

  def run
    begin
      @steps.times do
        @view.display
        @model.step
        sleep 0.03
      end
    rescue LifeModel::LifeIsStable
      puts "Life has stabilized"
    rescue Interrupt
      puts "OK, we're done here"
    end
  end
end

LifeController.new(
  :width  => nil,
  :height => nil,
  :steps  => nil
).run
