#
# Be sure to run `pod lib lint CPTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CPTools'
  s.version          = '0.2.8'
  s.summary          = 'CPTools encompasses some commonly used tools.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

    CPTools encompasses some commonly used tools developed by Pet Cao.

                       DESC

  s.homepage         = 'https://github.com/ITEnthusiast/CPTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pet Cao' => 'admin@caopei.cn' }
  s.source           = { :git => 'https://github.com/ITEnthusiast/CPTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

#s.public_header_files = 'CPTools/Headers/**/*.h'

    s.subspec 'Database' do |database|
        database.source_files = 'CPTools/Classes/Database/**/*'
    end

    s.subspec 'Network' do |network|
        network.source_files = 'CPTools/Classes/Network/**/*'
        network.dependency 'AFNetworking', '~> 3.1.0'
    end

    s.subspec 'UIKit' do |uikit|
        uikit.source_files = 'CPTools/Classes/UIKit/**/*'
    end

    s.subspec 'Audio' do |audio|
        audio.source_files = 'CPTools/Classes/Audio/**/*'
    end

    s.subspec 'Barrage' do |barrage|
        barrage.source_files = 'CPTools/Classes/Barrage/**/*.{m,h}'
        barrage.dependency 'CPTools/UIKit'
    end

  # s.resource_bundles = {
  #   'CPTools' => ['CPTools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
