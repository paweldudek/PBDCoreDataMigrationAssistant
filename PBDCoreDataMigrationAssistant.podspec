Pod::Spec.new do |s|
  s.name         = "PBDCoreDataMigrationAssistant"
  s.version      = "1.0.0"
  s.summary      = "Helpers classes to ease core data migration."
  s.homepage     = "https://github.com/paweldudek/PBDCoreDataMigrationAssistant"
  s.license      = {:type => 'MIT'}
  s.author       = { "Paweł Dudek" => "hello@dudek.mobi" }
  s.source       = { :git => "https://github.com/paweldudek/PBDCoreDataMigrationAssistant.git", :tag => "#{s.version}" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'PBDCoreDataMigrationAssistant/Lib/**/*.{h,m}'
end
