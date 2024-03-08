# OctopusSDK

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

OctopusSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

广告SDK安装

```ruby
pod 'OctopusSDK'
```

百度网盘定制SDK安装

```ruby
pod 'OctopusSDK/OctAdSDKNoShake'
```

Topon适配器SDK安装

```ruby
pod 'OctopusSDK/OctToponAdapterSDK'
```


## 工程设置

有的项目中可能会遇到下面的报错：
-[__NSCFString Oct_MD5String]: unrecognized selector sent to instance
这是由于OctCore.xcframework中的某些类别文件加载不全造成的，这里给出2种解决方案：

1。在other linker flags中，使用-force_load, 进行强制加载

-force_load

$(PROJECT_DIR)/Pods/OctopusSDK/OctopusSDK/OctCore.xcframework/ios-arm64/OctCore.framework/OctCore

2。手动将(PROJECT_DIR)/Pods/OctopusSDK/OctopusSDK/OctCore.xcframework加载到工程当中

## Author

zhaojinlong, zhaojinlong@adintl.cn

## License

OctopusSDK is available under the MIT license. See the LICENSE file for more info.
