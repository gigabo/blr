#!/usr/bin/ruby -w

%w[
  0
  0.0
  0..0
  []
  {}
  ""
  //
  self
  true
  false
  nil
  :a
].map  {|x| eval(x)}.
  sort {|a,b| a.methods.size <=> b.methods.size }.
  each {|x| puts "%15s: %4s" % ["#{x.class}", "#{x.methods.size}"] }
