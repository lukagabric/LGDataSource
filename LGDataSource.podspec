Pod::Spec.new do |s|
  s.name         = "LGDataSource"
  s.version      = "1.0"
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/lukagabric/LGDataSource'}
  s.source_files = "LGDataSource/Classes/Core/*.{h,m}"
  s.dependency 'PromiseKit', :git => 'https://github.com/mxcl/PromiseKit.git'
  s.dependency 'MBProgressHUD'
  s.requires_arc = true
end
