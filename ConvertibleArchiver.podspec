Pod::Spec.new do |s|
  s.name         = "ConvertibleArchiver"
  s.version      = "5.0.1"
  s.summary      = "Archiving For DataConvertible Types"
  s.description  = <<-DESC
                    Lightweight tool for archiving types that conform to DataConvertible (see Convertible framework).
                   DESC
  s.homepage     = "https://github.com/bradhilton/ConvertibleArchiver"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brad Hilton" => "brad@skyvive.com" }
  s.source       = { :git => "https://github.com/bradhilton/ConvertibleArchiver.git", :tag => s.version }
  s.swift_version = '5.0'

  s.ios.deployment_target = "8.0"
#  s.osx.deployment_target = "10.9"

  s.source_files  = "ConvertibleArchiver", "ConvertibleArchiver/**/*.{swift,h,m}"
  s.requires_arc = true
  s.dependency 'Convertible', '5.0.2'
end
