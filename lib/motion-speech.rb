unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

lib_dir_path = File.dirname(File.expand_path(__FILE__))
Motion::Project::App.setup do |app|
  gem_files = Dir.glob(File.join(lib_dir_path, "motion/**/*.rb"))
  app.files.unshift(gem_files).flatten!

  if app.deployment_target.to_f < 7.0
  	warn "AVSpeechSynthesizer and friends are only available in iOS 7.0+"
  end

  app.frameworks += %w(AVFoundation)
end
