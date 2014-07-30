require './app/server'

run Sinatra::Application

require 'rubygems'
require File.join(File.dirname(__FILE__), 'app/server.rb')

run BookmarkManager