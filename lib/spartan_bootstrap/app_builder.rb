module Suspenders
  class AppBuilder < Rails::AppBuilder
    include Suspenders::Actions

    # Overridden from Rails::AppBuilder

    def readme
      copy_file "README.md"
    end

    # Custom methods

    def remove_public_index
      remove_file 'public/index.html'
    end

    def remove_public_images_rails
      remove_file 'public/images/rails.png'
    end

    def create_application_layout
      template 'spartan_layout.html.haml', 'app/views/layouts/application.html.haml', :force => true
    end


    def include_custom_gems
      template 'Gemfile', 'Gemfile', :force => true
    end

    def configure_action_mailer
      action_mailer_host "development", "#{app_name}.local"
      action_mailer_host "test",        "example.com"
      action_mailer_host "staging",     "staging.#{app_name}.com"
      action_mailer_host "production",  "#{app_name}.com"
    end

    def generate_rspec
      generate "rspec:install"
    end

    def generate_cucumber
      generate "cucumber:install", "--rspec", "--capybara"
      inject_into_file "features/support/env.rb",
                       %{Capybara.save_and_open_page_path = 'tmp'\n} +
                       %{Capybara.javascript_driver = :webkit\n},
                       :before => %{Capybara.default_selector = :css}
    end

    def create_database
      bundle_command('exec rake db:create')
    end

    def configure_action_mailer
      action_mailer_host "development", "#{app_name}.local"
      action_mailer_host "test",        "example.com"
      action_mailer_host "staging",     "staging.#{app_name}.com"
      action_mailer_host "production",  "#{app_name}.com"
    end

    def generate_rspec
      generate "rspec:install"
      replace_in_file "spec/spec_helper.rb", "# config.mock_with :mocha", "config.mock_with :mocha"
    end

    def generate_cucumber
      generate "cucumber:install", "--rspec", "--capybara"
      inject_into_file "features/support/env.rb",
                       %{Capybara.save_and_open_page_path = 'tmp'\n} +
                       %{Capybara.javascript_driver = :webkit\n},
                       :before => %{Capybara.default_selector = :css}
    end

    def init_git
      template 'gitignore', '.gitignore', :force => true
      run "git init"
      run "git add -A ."
      run "git commit -m '#{app_name} - initial commit with spartan_bootstrap"
    end
  end
end
