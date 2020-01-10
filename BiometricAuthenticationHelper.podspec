#
# Be sure to run `pod lib lint BiometricAuthenticationHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
/Users/mike
Pod::Spec.new do |s|
  s.name             = 'BiometricAuthenticationHelper'
  s.version          = '0.1.0'
  s.summary          = 'This is a hlper that facilitaties the manage of the biometric device for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This Helepr is used for manage the biometric in the ios devices, touch id or face id.
                       DESC

  s.homepage         = 'https://github.com/MikeZarazua/BiometricAuthenticationHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'medinazarazuamike@gmail.com' => 'medinazarazuamike@gmail.com' }
  s.source           = { :git => 'https://github.com/MikeZarazua/BiometricAuthenticationHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version         = '4.0'

  s.source_files = 'BiometricAuthenticationHelper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BiometricAuthenticationHelper' => ['BiometricAuthenticationHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
