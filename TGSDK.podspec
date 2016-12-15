#
# Be sure to run `pod lib lint TGSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TGSDK'
  s.version          = '1.4.3'
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
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liyin' => 'liy@soulgame.com' }
  s.source           = { :git => 'https://github.com/soulgame/CocoaPods-TGSDK.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TGSDK/Classes/**/*'
  
  s.resource_bundles = {
     'TGSDK' => ['TGSDK/Assets/*']
  }

  s.public_header_files = 'TGSDK/Classes/include/TGSDK/TGSDK.h'
  s.library = 'stdc++', 'sqlite3', 'xml2', 'z'
  s.vendored_libraries = "TGSDK/libTGSDK.#{s.version}.a"
  s.frameworks = 'AudioToolbox', 'AVFoundation', 'CoreGraphics', 'CoreTelephony', 'EventKit', 'iAd', 'MediaPlayer', 'MessageUI', 'MobileCoreServices', 'QuartzCore', 'Social', 'StoreKit', 'SystemConfiguration', 'WebKit'
  s.vendored_frameworks = 'TGSDK/frameworks/AdColony.framework', 'TGSDK/frameworks/AppLovinSDK.framework', 'TGSDK/frameworks/ChanceAdSDK.framework', 'TGSDK/frameworks/Chartboost.framework', 'TGSDK/frameworks/FBAudienceNetwork.framework', 'TGSDK/frameworks/FMDB.framework', 'TGSDK/frameworks/NativeXSDK.framework', 'TGSDK/frameworks/UnityAds.framework', 'TGSDK/frameworks/VungleSDK.framework', 'TGSDK/frameworks/DomobVideoSDK.framework', 'TGSDK/frameworks/DianjoyVideo.framework', 'TGSDK/frameworks/AppTracker.framework', 'TGSDK/frameworks/MVSDK.framework', 'TGSDK/frameworks/MVSDKReward.framework'
end
