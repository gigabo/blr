#!/usr/bin/env ruby

class NewRubyUser
  def first_impressions
    "Ruby is cool."
  end
end

puts NewRubyUser.new.first_impressions

puts "... that's it?"

# Classes can be re-opened in Ruby
class NewRubyUser

  # Keep a pointer to the old method
  alias boring_first_impressions first_impressions

  # Put a new method behind the old name, and call the old method
  # (by the new name) from within it.
  def first_impressions
    boring = boring_first_impressions
    "-----===[[[#{boring.sub(/cool.$/){"AWESOME!!!"}}]]]===-----"
  end
end

puts NewRubyUser.new.first_impressions
