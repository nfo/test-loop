require 'test-loop'

TestLoop::Config.reabsorb_file_globs.push(
  'config/**/*.{rb,yml}',
  'db/schema.rb',
  'Gemfile.lock'
)

TestLoop::Config.test_file_matchers['{app,lib,test,spec}/**/*.rb'] =
  TestLoop::Config.test_file_matchers.delete('lib/**/*.rb')

require 'rails/railtie'
Class.new Rails::Railtie do
  config.before_initialize do |app|
    if app.config.cache_classes
      warn "test-loop: Setting #{app.class}.config.cache_classes = false"
      app.config.cache_classes = false
    end
  end
end
