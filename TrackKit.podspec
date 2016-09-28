Pod::Spec.new do |s|
  s.name             = 'TrackKit'
  s.version          = '1.2.0'
  s.summary          = 'Parse a GPX file into a readable format with Swift.'

  s.description      = <<-DESC
  This pod makes it possible to parse a GPX file to a format that can
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
  s.requires_arc = true

  # Set the default subspec.
  s.default_subspecs = 'GPX'

  # The core components of TrackKit.
  s.subspec 'Core' do |ss|
    ss.dependency 'AEXML', '~> 4.0'
    ss.source_files = 'Sources/Core/**/*'
  end

  # Everything needed to parse GPX files.
  s.subspec 'GPX' do |ss|
    ss.dependency 'TrackKit/Core'
    ss.source_files = 'Sources/GPX/**/*'
  end
end
