# Encoding: UTF-8
$:.push File.expand_path('../lib', __FILE__)
require 'refinery/newsletter/version'

version = Refinery::Newsletter::Version.to_s

Gem::Specification.new do |s|
  s.name              = %q{refinerycms-newsletter}
  s.version           = version
  s.description       = %q{A really straightforward open source Ruby on Rails newsletter engine designed for integration with Refinery CMS.}
  s.summary           = %q{Ruby on Rails newsletterging engine for Refinery CMS.}
  s.email             = %q{info@refinerycms.com}
  s.homepage          = %q{http://refinerycms.com/newsletter}
  s.authors           = ['Resolve Digital', 'Neoteric Design']
  s.require_paths     = %w(lib)
  s.licenses          = %q{MIT}

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  # Runtime dependencies
  s.add_dependency    'refinerycms-core',     '~> 2.0.3'
  s.add_dependency    'refinerycms-settings', '~> 2.0.1'
  s.add_dependency    'filters_spam',         '~> 0.2'
  s.add_dependency    'acts-as-taggable-on'
  s.add_dependency    'seo_meta',             '~> 1.3.0'
  s.add_dependency    'rails_autolink'

  # Development dependencies
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.0'
end
