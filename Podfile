platform :ios, '13.0'
use_frameworks!

workspace 'Ditto'

def shared_pods
  pod 'DLRadioButton', '1.4.12'
end

target 'DittoKit' do
  project 'DittoKit/DittoKit.xcodeproj'

  shared_pods

  target 'DittoKitTests' do
    inherit! :search_paths
    shared_pods
  end

end


target 'DittoApp' do
  project 'DittoApp/DittoApp.xcodeproj'

  # pod 'DittoKit/ThemeManager', :path => '../'
  shared_pods


  target 'DittoAppTests' do
    inherit! :search_paths
    shared_pods
  end

end

post_install do |installer|
  installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
             end
        end
 end
end
