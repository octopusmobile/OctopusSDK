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

## 工程设置

OctCore.xcframework中的某些类别文件会有加载不全的问题，这里给出2种解决方案：

1。在other linker flags中，使用-force_load, 进行强制加载

-force_load

$(PROJECT_DIR)/Pods/OctopusSDK/OctopusSDK/OctCore.xcframework/ios-arm64/OctCore.framework/OctCore

2。手动将(PROJECT_DIR)/Pods/OctopusSDK/OctopusSDK/OctCore.xcframework加载到工程当中。建议用这个方法

## Author

zhaojinlong, zhaojinlong@adintl.cn

## License

OctopusSDK is available under the MIT license. See the LICENSE file for more info.
