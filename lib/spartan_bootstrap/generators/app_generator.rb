require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Suspenders
  class Generator < Rails::Generators::AppGenerator

    class_option :skip_test_unit, :type => :boolean, :aliases => "-T", :default => true, :desc => "Skip Test::Unit files"

    class_option :heroku, :type => :boolean, :aliases => "-H", :default => false,
                          :desc => "initialize on Heroku"

    def finish_template
      invoke :spartan_bootstrap_customization
      super
    end

    def spartan_bootstrap_customization
      invoke :remove_files_we_dont_need
      invoke :create_application_layout
      invoke :customize_gemfile
      invoke :setup_database
      invoke :configure_app
      invoke :setup_root_route
      invoke :setup_git
      invoke :create_heroku_apps
      invoke :outro
    end

    def remove_files_we_dont_need
      build(:remove_public_index)
      build(:remove_public_images_rails)
    end

    def create_application_layout
      say "Creating application layout"
      build(:create_application_layout)
    end

    def customize_gemfile
      build(:include_custom_gems)
      bundle_command('install')
    end

    def setup_database
      say "Setting up database"
      build(:create_database)
    end

    def configure_app
      say "Configuring app"
      #build(:configure_action_mailer)
      build(:generate_rspec)
      #build(:generate_cucumber)
    end

    def setup_git
      say "Initializing git and initial commit"
      build(:gitignore_files)
      build(:init_git)
    end

    def setup_root_route
      say "Setting up a root route"
      build(:setup_root_route)
    end

    def create_heroku_apps
      if options['heroku']
        say "Creating heroku apps"
        build(:create_heroku_apps)
      end
    end

    def outro
      say "Congratulations! You just pulled our suspenders."
      say "Remember to run 'rails generate airbrake' with your API key."
    end

    protected

    def get_builder_class
      SpartanBootstrap::AppBuilder
    end

    def using_active_record?
      !options[:skip_active_record]
    end
  end
end
