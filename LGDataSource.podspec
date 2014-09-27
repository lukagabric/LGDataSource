Pod::Spec.new do |s|
  s.name         = "LGDataSource"
  s.version      = "1.0"
  s.platform     = :ios, '6.0'
  s.source       = { :git => 'https://github.com/lukagabric/LGDataSource'}
  s.source_files = "LGDataSource/Classes/Core/*.{h,m}"
  s.dependency 'PromiseKit', :podspec => 'https://github.com/mxcl/PromiseKit/PromiseKit.podspec'
  s.dependency 'MBProgressHUD'
  s.requires_arc = true
end
