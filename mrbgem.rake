MRuby::Gem::Specification.new('mruby-autoload') do |spec|
  spec.license = 'MIT'
  spec.authors = 'Chris Roberts <code@chrisroberts.org>'
  spec.version = '0.1.0'
  spec.description = 'Auto load support on missing constant'
  spec.homepage = 'https://github.com/spox/mruby-autoload'
  spec.add_dependency 'mruby-require'
end
