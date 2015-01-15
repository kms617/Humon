require 'webmock/rspec'
# http://rubydoc.info/gems/nspec-core/rSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
  end

  # filter_run is short-form alias for filter_run_including
  config.filter_run focus: true

  config.order = :random

  # config.include Monban::Test::Helpers, type: :feature
  #   config.after :each do
  #     Monban.test_reset!
  #   end
end

WebMock.disable_net_connect!(allow_localhost: true)


# Monban.test_mode!
#
# RSpec.configure do |config|
#   config.include Monban::Test::Helpers, type: :feature
#   config.after :each do
#     Monban.test_reset!
#   end
# end
