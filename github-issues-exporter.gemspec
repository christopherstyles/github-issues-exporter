# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_issues_exporter/version'

Gem::Specification.new do |spec|
  spec.name          = 'github_issues_exporter'
  spec.version       = GithubIssuesExporter::VERSION
  spec.authors       = ['Christopher Styles']
  spec.email         = ['christopherstyles@gmail.com']
  spec.summary       = %q{An exporter for github issues.}
  spec.description   = %q{An exporter to various formats from github issues.}
  spec.homepage      = 'http://github-issues-exporter.herokuapp.com/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.1.2'

  spec.add_dependency 'bundler', '~> 1.6'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'octokit'
  spec.add_dependency 'sinatra'
  spec.add_dependency 'sinatra_auth_github'
  spec.add_dependency 'sinatra-contrib'
  spec.add_dependency 'sinatra-partial'
  spec.add_dependency 'slim'
end

