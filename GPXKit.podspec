Pod::Spec.new do |s|
  s.name             = 'GPXKit'
  s.version          = '1.0.0'
  s.summary          = 'Parse a GPX file to a Swift representable struct.'

  s.description      = <<-DESC
  This pod makes it possible to parse a GPX file to a format that can
  be easily used in your code.
                       DESC

  s.homepage         = 'https://github.com/fousa/gpxkit'
  s.license          = 'MIT'
  s.author           = { 'Jelle Vandebeeck' => 'jelle@fousa.be' }
  s.source           = { git: 'https://github.com/fousa/gpxkit.git', tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/fousa'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.dependency 'AEXML', '~> 2.1.0'
end
