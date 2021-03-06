Pod::Spec.new do |s|
  s.name         = 'BlueprintUI'
  s.version      = '0.3.1'
  s.summary      = 'Swift library for declarative UI construction'
  s.homepage     = 'https://www.github.com/square/blueprint'
  s.license      = 'Apache License, Version 2.0'
  s.author       = 'Square'
  s.source       = { :git => 'https://github.com/square/blueprint.git', :tag => s.version }

  s.swift_version = '5.0'

  s.ios.deployment_target = '9.3'

  s.source_files = 'BlueprintUI/Sources/**/*.swift'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'BlueprintUI/Tests/**/*.swift'
    test_spec.framework = 'XCTest'
  end
  
end
