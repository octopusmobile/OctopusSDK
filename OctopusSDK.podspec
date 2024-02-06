Pod::Spec.new do |spec|

  spec.name         = "OctopusSDK"
  spec.version      = "1.5.9.9"
  spec.summary      = "OctopusSDK"


  spec.description  = <<-DESC
TODO: Add long description of the pod here.
                   DESC

  spec.homepage     = "https://gitee.com/it2699/octopus-sdk.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "zhaojinlong" => "zhaojinlong@adintl.cn" }

  spec.platform     = :ios, "10.0"


  spec.source       = {:git => 'https://github.com/octopusmobile/OctopusSDK.git', :tag => spec.version}

  spec.source_files = 'OctopusSDK/Classes/**/*.{h,m}','OctopusSDK/OctAdSDK.framework/Headers/*.h'
  spec.vendored_frameworks = 'OctopusSDK/*.framework'

end
