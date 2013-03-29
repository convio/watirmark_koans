#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/edgecase')

class AboutWatirmark < EdgeCase::Koan

  def test_one
    require "watirmark"
  end

  def test_two
    assert false
  end
end