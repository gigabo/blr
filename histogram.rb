
class Histogram
  DEFAULT_WIDTH = 80
  def initialize(args={})

    @width = args[:width] || DEFAULT_WIDTH

    if t = args[:tuples]
      self.tuples = t
    end
  end

  def tuples=(t)
    @tuples = t
  end

  def display
    max_key_length    = @tuples.collect{|i| i[0].length}.max
    max_value         = @tuples.collect{|i| i[1]}.max
    max_value_length  = max_value.to_s.length

    boilerplate = 3 # Spaces and ':'

    hist_width = @width - boilerplate - max_key_length - max_value_length

    template = "%#{max_key_length}s %#{max_value_length}d: %s"
    @tuples.each do |key, value|
      bar = 'X' * (value * hist_width / max_value)
      puts template % [key, value, bar]
    end
  end
end


