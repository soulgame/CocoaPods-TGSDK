#
# Be sure to run `pod lib lint TGSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TGSDK'
  s.version          = '1.7.0'
  s.summary          = 'Yomob Ad SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Yomob Ad SDK.
                       DESC

  s.homepage         = 'https://yomob.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yomob' => 'support@yomob.com' }
  s.source           = { :git => 'https://github.com/soulgame/CocoaPods-TGSDK.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TGSDK/Classes/**/*'
  
  s.resources = ['TGSDK/Assets/*']

  s.public_header_files = 'TGSDK/Classes/include/TGSDK/TGSDK.h'
  s.library = 'stdc++', 'sqlite3', 'xml2', 'z'
  s.vendored_libraries = "TGSDK/libTGSDK.#{s.version}.a"
  s.frameworks = 'Accelerate', 'AdSupport', 'AudioToolbox', 'AVFoundation', 'CFNetwork', 'CoreGraphics', 'CoreLocation', 'CoreTelephony', 'CoreMedia', 'CoreMotion', 'EventKit', 'Foundation', 'GameController', 'GLKit', 'iAd', 'ImageIO', 'MediaPlayer', 'MessageUI', 'MobileCoreServices', 'QuartzCore', 'Security', 'Social', 'StoreKit', 'SystemConfiguration', 'WebKit', 'JavaScriptCore', 'UIKit'
  s.vendored_frameworks = 'TGSDK/frameworks/AdColony.framework', 'TGSDK/frameworks/AppLovinSDK.framework', 'TGSDK/frameworks/AppTracker.framework', 'TGSDK/frameworks/AppnextLib.framework', 'TGSDK/frameworks/AppnextSDKCore.framework', 'TGSDK/frameworks/Centrixlink.framework', 'TGSDK/frameworks/ChanceAdSDK.framework', 'TGSDK/frameworks/Chartboost.framework', 'TGSDK/frameworks/FBAudienceNetwork.framework', 'TGSDK/frameworks/FMDB.framework', 'TGSDK/frameworks/GoogleMobileAds.framework', 'TGSDK/frameworks/IronSource.framework', 'TGSDK/frameworks/MVSDK.framework', 'TGSDK/frameworks/MVSDKInterstitial.framework', 'TGSDK/frameworks/MVSDKReward.framework', 'TGSDK/frameworks/OneWaySDK.framework', 'TGSDK/frameworks/Tapjoy.framework', 'TGSDK/frameworks/UnityAds.framework', 'TGSDK/frameworks/VungleSDK.framework'
end
