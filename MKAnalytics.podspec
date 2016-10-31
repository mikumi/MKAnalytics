#
# Be sure to run `pod lib lint MKAnalytics.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKAnalytics'
  s.version          = '0.1.1'
  s.summary          = 'A wrapper around various analytics services'

  s.description      = <<-DESC
Easily send events and other analytics information to multiple services at once, such as Mixpanel, GoogleAnalytics,
Crashlytics or Facebook Analytics. Implementing the MKAnalyticsService.h allows easy adoption of other services.
                       DESC

  s.homepage         = 'https://github.com/mikumi/MKAnalytics'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Michael Kuck' => 'me@michael-kuck.com' }
  s.source           = { :git => 'https://github.com/mikumi/MKAnalytics.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/michaelkuckcom'

  s.ios.deployment_target = '8.0'

  s.default_subspec = 'Core'
  s.subspec 'Core' do |sp|
    sp.source_files = 'MKAnalytics/Classes/*'
  end

  s.subspec 'Crashlytics' do |sp|
    sp.source_files = 'MKAnalytics/Classes/Crashlytics/*'
    sp.dependency 'MKAnalytics/Core'
    sp.dependency 'Fabric', '~> 1.6'
    sp.dependency 'Crashlytics', '~> 3.8'
  end

  s.subspec 'Facebook' do |sp|
    sp.source_files = 'MKAnalytics/Classes/Facebook/*'
    sp.dependency 'MKAnalytics/Core'
    sp.dependency 'FBSDKCoreKit', '~> 4.16'
  end

  s.subspec 'GoogleAnalytics' do |sp|
    sp.source_files = 'MKAnalytics/Classes/GoogleAnalytics/*'
    sp.dependency 'MKAnalytics/Core'
    sp.dependency 'GoogleAnalytics', '~> 3.14'
  end

  s.subspec 'Mixpanel' do |sp|
    sp.source_files = 'MKAnalytics/Classes/Mixpanel/*'
    sp.dependency 'MKAnalytics/Core'
    sp.dependency 'Mixpanel', '~> 3.0.4'
  end

end

