#!/usr/bin/env ruby

class Outer
  OUT_OF_REACH = "Can't touch this!"
end

# This creates a class with a nested name, but the definiton
# isn't in a nested lexical scope with respect to the Outer class
class Outer::NestedNameOnly
  def reach_into_outer_guts
    OUT_OF_REACH
  end
end

begin
  Outer::NestedNameOnly.new.reach_into_outer_guts

rescue NameError => e
  puts "NestedNameOnly Caught #{e.class}: #{e.message}"
end

# This actually re-opens the lexical scope of the Outer class definition,
# so the OUT_OF_REACH constant is actually available.
class Outer
  class NestedLexicalScope
    def reach_into_outer_guts
      OUT_OF_REACH
    end
  end
end

puts "NestedLexicalScope succeeded: #{
  Outer::NestedLexicalScope.new.reach_into_outer_guts
}"
