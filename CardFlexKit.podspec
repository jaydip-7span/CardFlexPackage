
Pod::Spec.new do |s|
  s.name             = 'CardFlexKit'
  s.version          = '0.0.1'
  s.swift_versions   = ['5.0']
  s.authors          = { 'Jaydip' => 'jaydip@7span.com' }
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = 'https://github.com/jaydip-7span/CardFlexKit'
  s.source           = { :git => 'https://github.com/jaydip-7span/CardFlexKit.git', :tag => '0.0.1' }
  s.summary          = 'A flexible iOS library for managing card layouts and animations with user input validation.'
  s.description      = <<-DESC
CardFlexKit is a flexible iOS library for managing card layouts with interactive animations and user input validation. It allows easy customization of card designs, animations, and integrates validation mechanisms for user interactions.
  DESC
  s.url              = 'https://github.com/jaydip-7span/CardFlexKit'
end
