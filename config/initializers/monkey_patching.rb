Dir[Rails.root.join('lib', 'monkey_patching', '*.rb')].each { |file| require file }
