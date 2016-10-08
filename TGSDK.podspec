#
# Be sure to run `pod lib lint TGSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TGSDK'
  s.version          = '1.4.0.0.0'
  s.summary          = 'Yomob Ad SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Yomob Ad SDK.
                       DESC

  s.homepage         = 'http://yomob.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liyin' => 'liy@soulgame.com' }
  s.source           = { :git => 'https://github.com/soulgame/TGSDK.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TGSDK/Classes/**/*'
  
  s.resource_bundles = {
     'TGSDK' => ['TGSDK/Assets/*']
  }

  s.public_header_files = 'Pod/Classes/include/TGSDK/TGSDK.h'
  s.library = 'sqlite3', 'xml2', 'z'
  s.vendored_library = "TGSDK.#{s.version}"
  s.frameworks = 'AudioToolbox', 'AVFundation', 'CoreGraphics', 'CoreTelephony', 'EventKit', 'iAd', 'MediaPlayer', 'MessageUI', 'MobileCoreServices', 'QuartzCore', 'Social', 'StoreKit', 'SystemConfiguration', 'WebKit'
  s.vendored_frameworks = 'frameworks/*'
  # s.dependency 'AFNetworking', '~> 2.3'
end
