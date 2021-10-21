# Uncomment the next line to define a global platform for your project
 platform :ios, '14.0'

target 'SpaceXRockets' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SpaceXRockets
  pod 'SwiftLint'
  pod 'Nuke'
  pod 'Kingfisher', '~> 5.0'
  pod 'FeedKit'
  pod "PromiseKit", "~> 6.8"
  
  target 'SpaceXRocketsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SpaceXRocketsUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
