Pod::Spec.new do |spec|

  spec.name         = "OctopusSDK"
  spec.version      = "1.5.9.10"
  spec.summary      = "OctopusSDK"


  spec.description  = <<-DESC
TODO: Add long description of the pod here.
                   DESC

  spec.homepage     = "https://github.com/octopusmobile/OctopusSDK.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "zhaojinlong" => "zhaojinlong@adintl.cn" }

  spec.platform     = :ios, "10.0"


  spec.source       = {:git => 'https://github.com/octopusmobile/OctopusSDK.git', :tag => spec.version}

  spec.source_files = 'OctopusSDK/Classes/**/*.{h,m}','OctopusSDK/OctAdSDK.xcframework/ios-arm64/OctAdSDK.framework/Headers/*.h'
  spec.vendored_frameworks = 'OctopusSDK/*.xcframework'

end
