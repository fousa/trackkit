Pod::Spec.new do |s|
  s.name             = 'TrackKit'
  s.version          = '2.4.0'
  s.summary          = 'Parse a log file into a readable format with Swift.'

  s.description      = <<-DESC
  This pod makes it possible to parse a GPX/LOC/NMEA/TCX file to a format that can
  be easily used in your code.
                       DESC

  s.homepage         = 'https://github.com/fousa/trackkit'
  s.license          = 'MIT'
  s.author           = { 'Jelle Vandebeeck' => 'jelle@fousa.be' }
  s.source           = { git: 'https://github.com/fousa/trackkit.git', tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/fousa'

  s.ios.deployment_target     = '9.0'
  s.osx.deployment_target     = '10.11'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'

  # Set source file requirements.
  s.requires_arc = true
  s.source_files = 'Sources/Classes/**/*'

  # Add the Fit framework.
  s.ios.vendored_framework = 'Sources/Vendor/iOS/Fit.framework'
  s.ios.user_target_xcconfig = { 
    'FRAMEWORK_SEARCH_PATHS' => "'#{File.join(File.dirname(__FILE__), 'Sources/Vendor/iOS')}'"
  }
  s.osx.vendored_framework = 'Sources/Vendor/macOS/Fit.framework'
  s.osx.user_target_xcconfig = { 
    'FRAMEWORK_SEARCH_PATHS' => "'#{File.join(File.dirname(__FILE__), 'Sources/Vendor/macOS')}'"
  }

  # Dependencies
  s.dependency 'AEXML', '~> 4.3'
end
