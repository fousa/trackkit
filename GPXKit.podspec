Pod::Spec.new do |s|
  s.name             = 'GPXKit'
  s.version          = '1.1.0'
  s.summary          = 'Parse a GPX file into a readable format with Swift.'

  s.description      = <<-DESC
  This pod makes it possible to parse a GPX file to a format that can
  be easily used in your code.
                       DESC

  s.homepage         = 'https://github.com/fousa/gpxkit'
  s.license          = 'MIT'
  s.author           = { 'Jelle Vandebeeck' => 'jelle@fousa.be' }
  s.source           = { git: 'https://github.com/fousa/gpxkit.git', tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/fousa'

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*'

  s.dependency 'AEXML', '~> 2.1'
end
