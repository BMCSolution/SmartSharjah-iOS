# Uncomment the next line to define a global platform for your project

platform :ios, '10.0'

target 'smartSharjah' do
  # Comment the next line if you don't want to use dynamic frameworks


  use_frameworks!
	pod 'SwiftyJSON','~> 4.0'
	pod 'Alamofire'
 	pod 'MaterialComponents/Buttons'
	pod 'Kingfisher'
  pod 'AlamofireRSSParser'
  pod 'TPKeyboardAvoidingSwift'
  pod 'IQKeyboardManagerSwift'
  pod 'Tags'
  pod 'SideMenu', '~> 5.0'
  pod 'DropDown'
  pod 'HTMLParser'
  pod 'Fabric', '~> 1.10.2'
  pod 'Crashlytics', '~> 3.14.0'
  pod 'Firebase/Analytics'
  #pod 'Alamofire-SwiftyXMLParser', '~> 1.0.0-alpha1'
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'ArcGIS-Runtime-SDK-iOS'
  pod 'TIFeedParser', '~> 2.2'
  	# if use Xcode9(Swift4.0) -- now we use swift 4.2
  	post_install do |installer|
    		installer.pods_project.targets.each do |target|


      	$version = '4.2'
      	case target.name
        when 'Alamofire'
        $version = '4.2'

        when 'SideMenu'
        $version = '4.2'

      	end
      	target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = $version
      end
    end
  end

end
