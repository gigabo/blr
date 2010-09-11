#!/usr/bin/env ruby

class Outer
  OUT_OF_REACH = "Can't touch this!"
end

class Outer::NestedNameOnly
  def reach_into_outer_guts
    OUT_OF_REACH
  end
end

begin
  Outer::NestedNameOnly.new.reach_into_outer_guts

rescue NameError => e
  puts "Caught #{e.class}: #{e.message}"
end
