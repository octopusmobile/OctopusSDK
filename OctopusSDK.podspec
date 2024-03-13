Pod::Spec.new do |spec|
  
  spec.name         = "OctopusSDK"
  spec.version      = "1.5.9.22"
  spec.summary      = "OctopusSDK"
  
  
  spec.description  = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  spec.homepage     = "https://github.com/octopusmobile/OctopusSDK.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  spec.author             = { "zhaojinlong" => "zhaojinlong@adintl.cn" }
  
  spec.ios.deployment_target = '12.0'
  spec.static_framework = true
  spec.libraries = ["c++"]
  spec.frameworks = 'SystemConfiguration', 'CoreGraphics','Foundation','UIKit', 'AppTrackingTransparency'
  
  
  spec.source       = {:git => 'https://github.com/octopusmobile/OctopusSDK.git', :tag => spec.version}

  spec.default_subspecs = 'OctopusBaseSDK'
  
  spec.subspec 'OctopusBaseSDK' do |ss|
    ss.ios.deployment_target = '12.0'
    ss.vendored_frameworks = 'OctopusSDK/OctAdSDK.xcframework', 'OctopusSDK/OctCore.xcframework'
  end
  spec.subspec 'OctToponAdapterSDK' do |ss|
    ss.ios.deployment_target = '12.0'
    ss.vendored_frameworks = 'OctopusSDK/OctToponAdapterSDK.xcframework'
    ss.dependency 'AnyThinkiOS'
    ss.dependency 'OctopusSDK/OctopusBaseSDK'
  end
  spec.subspec 'OctAdSDKNoShake' do |ss|
    ss.ios.deployment_target = '12.0'
    ss.vendored_frameworks = 'OctopusSDKNoShake/OctAdSDK.xcframework', 'OctopusSDK/OctCore.xcframework'
  end
  spec.subspec 'OctToponAdapterSourceCodeSDK' do |ss|
    ss.ios.deployment_target = '12.0'
    ss.source_files = 'OctToponAdapterSourceCodeSDK/Classes/**/*'
    ss.dependency 'AnyThinkiOS'
    ss.dependency 'OctopusSDK/OctopusBaseSDK'
  end
end
