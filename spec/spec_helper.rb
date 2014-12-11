# coding: utf-8

require "rubygems"
require "bundler/setup"
require 'rspec'
require 'stringio'
Dir[File.join(File.dirname(__FILE__), "..", "app", "**/*.rb")].each{|f| require f }

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval "$#{stream} = #{stream.upcase}"
  end
  result
end


RSpec.configure do
  # ...
end
