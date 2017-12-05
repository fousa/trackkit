Pod::Spec.new do |s|
  s.name             = 'TrackKit'
  s.version          = '2.3.2'
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
  s.source_files = 'Sources/**/*'

  # Dependencies
  s.dependency 'AEXML', '~> 4.2'
end
