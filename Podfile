# Uncomment the next line to define a global platform for your project
 platform :ios, '8.0'

workspace 'PCCWFoundationSwift'

def libraries
    # https://github.com/realm/realm-cocoa
    pod 'RealmSwift'
    
    # https://github.com/ninjaprox/NVActivityIndicatorView
    pod 'NVActivityIndicatorView'
    
    # https://github.com/SnapKit/SnapKit
    pod 'SnapKit'
    
    # https://github.com/hackiftekhar/IQKeyboardManager
    pod 'IQKeyboardManagerSwift'
    
    # https://github.com/jakenberg/ObjectMapper-Realm
    pod 'ObjectMapper+Realm'
    
    # https://github.com/ivanbruel/Moya-ObjectMapper
    pod 'Moya-ObjectMapper/RxSwift'
    
    # https://github.com/ReactiveX/RxSwift
    pod 'RxSwift'
    pod 'RxCocoa'
    
    #  # https://github.com/forkingdog/FDStackView/tree/master
    #  pod 'FDStackView'
    
    # https://github.com/dennisweissmann/DeviceKit
    pod 'DeviceKit'
    
    # https://github.com/kishikawakatsumi/KeychainAccess
    pod 'KeychainAccess'
    
    # https://github.com/RxSwiftCommunity/RxRealm
    pod 'RxRealm'
    
    # https://github.com/CoderMJLee/MJRefresh
    pod 'MJRefresh'
    
    # https://github.com/yeahdongcn/UIColor-Hex-Swift
    pod 'UIColor_Hex_Swift'
    
    # https://github.com/suzuki-0000/SKPhotoBrowser
    #  pod 'SKPhotoBrowser'
    
    # https://github.com/onevcat/Kingfisher
    pod 'Kingfisher'
    
    #  https://github.com/banchichen/TZImagePickerController
    pod 'TZImagePickerController'
    
    #  https://github.com/ruslanskorb/RSKGrowingTextView
    pod 'RSKGrowingTextView'
    
    pod 'Kanna'
end

target 'PCCWFoundationSwift' do
    inhibit_all_warnings!
    use_frameworks!

    libraries
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
    
    target 'Demo' do
        project 'iOS Example/Demo.xcodeproj'
        
    end
    
end

#abstract_target 'Shared' do
#    inhibit_all_warnings!
#    use_frameworks!
#        
#    libraries
#
#    target 'Demo' do
#        project 'iOS Example/Demo.xcodeproj'
#
#    end
#    
#    
#    target 'PCCWFoundationSwift' do
#        project 'PCCWFoundationSwift.xcodeproj'
#
#    end
#end
