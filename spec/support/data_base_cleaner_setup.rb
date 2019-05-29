RSpec.configure do |config|

  # Functional test Doesn't run the middleware.
  # Controller spec is functional test.As per document functional test is isolated one
  # So, We need to manually switch to our test DB for functional test cases.


  # default before/after hooks will be applied for each example
  config.before do
    # here We have mentioned one time for strategy.It will be applied for all cleaners which have been added
    # Refer database_cleaner-1.7.0/lib/database_cleaner/configuration.rb file for more info
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.append_after do
    DatabaseCleaner.clean
  end

end

