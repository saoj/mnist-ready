
Gem::Specification.new do |s|
    s.name        = 'mnist-ready'
    s.version     = '1.1.1'
    s.licenses    = ['MIT']
    s.summary     = "A simple and straightforward Ruby library that handles everything related to the MNIST database."
    s.authors     = ["Sergio Oliveira Jr"]
    s.email       = 'sergio.oliveira.jr@gmail.com'
    s.files       = Dir['lib/**/*.rb'] + Dir['data/*.csv']
    s.homepage    = 'https://github.com/saoj/mnist-ready'
    s.required_ruby_version = '>= 3.0.0'
  end
