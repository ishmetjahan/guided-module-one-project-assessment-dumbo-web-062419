require_relative '../config/environment'
require 'tty-prompt'
require 'pry'
ActiveRecord::Base.logger = nil



cli = Interface.new
cli.login_menu


#binding.pry
