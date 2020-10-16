# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = '${NAME}'
  s.version     = '0.0.1'
  s.date        = '2019-01-10'
  s.licenses    = ['MIT']
  s.summary     = 'Example ruby pipeline for Gaia pipelines (https://gaia-pipeline.io).'
  s.authors     = ['Ops']
  s.email       = 'ops@root.com'
  s.homepage    = 'https://gaia-pipeline.io'
  s.files       = Dir['{lib}/**/*.rb', 'bin/*']
  s.add_runtime_dependency 'rubysdk', ['~> 0.0.1']
  # s.add_runtime_dependency 'shell', ['~> 0.8.1']
end
