#
# Be sure to run `pod lib lint Flatline.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Flatline'
  s.version          = '1.0.3'
  s.summary          = 'A Framework to Provide a Base Architecture for a Service Based Network Architecture'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Flatline is meant to provide a Base Architecture for a Service Based Network Architecture. By Subclassing the BaseNetworkService, and registering any Network Framework you choose, it allows you to easily interface with your network layer in an easy to use manner. 
                       DESC

  s.homepage         = 'https://github.com/JoshHenderson/Flatline'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Josh Henderson' => 'henderson.josh1@gmail.com' }
  s.source           = { :git => 'https://github.com/JoshHenderson/Flatline.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Flatline/**/*.{swift}' 
  
  # s.resource_bundles = {
  #   'Flatline' => ['Flatline/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'Quick'
end
