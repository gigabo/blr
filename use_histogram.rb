#!/usr/bin/env ruby

require 'histogram'

data = [
  ["Sunday",    9],
  ["Monday",    8],
  ["Tuesday",   7],
  ["Wednesday", 7],
  ["Thursday",  6],
  ["Friday",    6],
  ["Saturday", 11],
]

Histogram.new(:tuples => data).display

