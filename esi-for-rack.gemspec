# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{esi-for-rack}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Hull"]
  s.date = %q{2009-07-21}
  s.description = %q{ESI for Rack}
  s.email = %q{joshbuddy@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/esi_for_rack.rb",
     "lib/esi_for_rack/lookup.rb",
     "lib/esi_for_rack/node.rb",
     "spec/http_integration/accept_language_spec.rb",
     "spec/http_integration/cookie_spec.rb",
     "spec/http_integration/fixtures/accept_language/1.html",
     "spec/http_integration/fixtures/cookie/1.html",
     "spec/http_integration/fixtures/query_string/1.html",
     "spec/http_integration/fixtures/user_agent/1.html",
     "spec/http_integration/query_string_spec.rb",
     "spec/http_integration/user_agent_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/tags/choose_spec.rb",
     "spec/tags/comment_spec.rb",
     "spec/tags/fixtures/choose/simple1.html",
     "spec/tags/fixtures/choose/simple2.html",
     "spec/tags/fixtures/choose/simple3.html",
     "spec/tags/fixtures/comment/simple.html",
     "spec/tags/fixtures/include/alt.html",
     "spec/tags/fixtures/include/src.html",
     "spec/tags/fixtures/include/src_continue.html",
     "spec/tags/fixtures/nested/complex.html",
     "spec/tags/fixtures/try/include.html",
     "spec/tags/fixtures/try/malformed_attempt.html",
     "spec/tags/fixtures/try/malformed_except.html",
     "spec/tags/fixtures/vars/simple.html",
     "spec/tags/include_spec.rb",
     "spec/tags/nested_spec.rb",
     "spec/tags/try_spec.rb",
     "spec/tags/vars_spec.rb"
  ]
  s.homepage = %q{http://github.com/joshbuddy/esi_for_rack}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{ESI for Rack}
  s.test_files = [
    "spec/http_integration/accept_language_spec.rb",
     "spec/http_integration/cookie_spec.rb",
     "spec/http_integration/query_string_spec.rb",
     "spec/http_integration/user_agent_spec.rb",
     "spec/spec_helper.rb",
     "spec/tags/choose_spec.rb",
     "spec/tags/comment_spec.rb",
     "spec/tags/include_spec.rb",
     "spec/tags/nested_spec.rb",
     "spec/tags/try_spec.rb",
     "spec/tags/vars_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<joshbuddy-esi_attribute_language>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<jaxn-parse_user_agent>, [">= 0"])
    else
      s.add_dependency(%q<joshbuddy-esi_attribute_language>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<jaxn-parse_user_agent>, [">= 0"])
    end
  else
    s.add_dependency(%q<joshbuddy-esi_attribute_language>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<jaxn-parse_user_agent>, [">= 0"])
  end
end
