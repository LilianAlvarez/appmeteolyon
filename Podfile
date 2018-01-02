# Uncomment the next line to define a global platform for your project
platform :ios, '11.1'


  target 'Weather' do
    pod 'Alamofire', '~> 4.5'
    
  use_frameworks!

  target 'WeatherTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WeatherUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
      end
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
          end
      end
  end

end
