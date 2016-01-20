# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "fluent-plugin-json-merge"
  s.version = "1.0"
  s.homepage = "https://github.com/ReturnPath/fluent-plugin-json-merge"
  s.summary = "fluentd plugin to merge a child json string into the main hash"
  s.description = s.summary
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_runtime_dependency "fluentd"
  s.add_development_dependency "rake"
  s.add_development_dependency "test-unit"
end
