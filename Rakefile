begin
  require 'esi_for_rack'
  Jeweler::Tasks.new do |s|
    s.name = "esi_for_rack"
    s.description = s.summary = "ESI for Rack"
    s.email = "joshbuddy@gmail.com"
    s.homepage = "http://github.com/joshbuddy/esi_for_rack"
    s.authors = ["Joshua Hull"]
    s.files = FileList["[A-Z]*", "{lib,spec}/**/*"]
    s.add_dependency 'joshbuddy-esi_attribute_language'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'spec'
require 'spec/rake/spectask'

task :spec => 'spec:all'
namespace(:spec) do
  Spec::Rake::SpecTask.new(:all) do |t|
    t.spec_opts ||= []
    t.spec_opts << "-rubygems"
    t.spec_opts << "--options" << "spec/spec.opts"
    t.spec_files = FileList['spec/**/*.rb']
  end

end
