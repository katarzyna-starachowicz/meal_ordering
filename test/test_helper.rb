ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

OmniAuth.config.test_mode = true
omniauth_hash = { 'provider' => 'github',
                  'uid' => '12345',
                  'info' => { 'name' => 'Zofia' }
                }

OmniAuth.config.add_mock(:github, omniauth_hash)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include Capybara::DSL
  # Add more helper methods to be used by all tests here...
  def login_user
    visit root_path
    click_link "Log in via GitHub"
  end
end
