Pod::Spec.new do |s|
  s.name         = "PBDCoreDataMigrationAssistant"
  s.version      = "1.0.1"
  s.summary      = "Helpers classes to ease core data migration."
  s.homepage     = "https://github.com/paweldudek/PBDCoreDataMigrationAssistant"
  s.license      = {:type => 'MIT', :file=>'LICENSE'}
  s.author       = { "Paweł Dudek" => "hello@dudek.mobi" }
  s.source       = { :git => "https://github.com/paweldudek/PBDCoreDataMigrationAssistant.git", :tag => "#{s.version}" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'PBDCoreDataMigrationAssistant/Classes/Lib/**/*.{h,m}'
end
