require 'Capybara'
require 'Capybara/cucumber'
require 'rspec'
require 'capybara/poltergeist'
require "fileutils"



@@PICS_PATH = "E:/GitHub/Pics/app/public/"

#
#Capybara.default_driver = :poltergeist
#Capybara.register_driver :poltergeist do |app|
#    options = {
#        :js_errors => true,
#        :timeout => 120,
#        :debug => false,
#        :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
#        :inspector => true,
#    }
#    Capybara::Poltergeist::Driver.new(app, options)
#end

# Capybara.default_driver = :selenium

# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

# Capybara.javascript_driver = :chrome
Capybara.exact = true

Capybara.default_driver = :selenium
class CapybaraDriverRegistrar
  # register a Selenium driver for the given browser to run on the localhost
  def self.register_selenium_driver(browser)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => browser)
    end
  end
end
#CapybaraDriverRegistrar.register_selenium_driver(:internet_explorer)
#CapybaraDriverRegistrar.register_selenium_driver(:firefox)
CapybaraDriverRegistrar.register_selenium_driver(:chrome)