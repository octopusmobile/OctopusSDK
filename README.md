# OctopusSDK

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

OctopusSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OctopusSDK'
```

##工程设置
在other linker flags中，OctCore需要使用-force_load, 进行强制加载， 否则会有类别文件加载不全的问题：

-force_load
$(PROJECT_DIR)/Pods/OctopusSDK/OctopusSDK/OctCore.xcframework/ios-arm64/OctCore.framework/OctCore

## Author

zhaojinlong, zhaojinlong@adintl.cn

## License

OctopusSDK is available under the MIT license. See the LICENSE file for more info.
