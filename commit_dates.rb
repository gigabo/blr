#!/usr/bin/env ruby

require 'date'
require 'histogram'

class CommitsByDay
  def initialize(args={})
    if repo = args[:repo]
      page = "http://github.com/api/v2/yaml/commits/list/#{repo}/master"
      @command = "curl #{page}"
      @pattern = /authored_date: (.+)/
      obtaining = "Fetching remotely"
    else
      @command = "git log"
      @pattern = /^Date:\s+(.+)/
      obtaining = "Gathering locally"
    end
    @by_wday = {}
    puts "#{obtaining} via `#{@command}`"
    fetch
  end
  def tuples
    Date::ABBR_DAYNAMES.collect { |wday| [ wday, @by_wday[wday] || 0 ] }
  end
  private
  def fetch
    IO.popen(@command) do |io|
      io.each do |line|
        if match = line.match(@pattern)
          adate = DateTime.parse(match[1])
          wday = Date::ABBR_DAYNAMES[adate.wday]
          @by_wday[wday] ||= 0
          @by_wday[wday] += 1
        end
      end
    end
  end
end

Histogram.new(:tuples => CommitsByDay.new(:repo => ARGV[0]).tuples).display
