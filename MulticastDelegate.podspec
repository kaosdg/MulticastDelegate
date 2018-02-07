#
# Be sure to run `pod lib lint MulticastDelegate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MulticastDelegate'
  s.version          = '0.1.0'
  s.summary          = 'MulticastDelegate - A linked list of delegates, also called an invokation list.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MulticastDelegate - A linked list of delegates, also called an invokation list.

- When a multicast delegate is invoked, the delegates in the list are called synchronously in the order in which they've been added to the delegate table.

- Delegate invocation will run on the caller's thread.
                       DESC

  s.homepage         = 'https://github.com/kaosdg/MulticastDelegate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Karl Catigbe' => 'spam@gmail.com' }
  s.source           = { :git => 'https://github.com/kaosdg/MulticastDelegate.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = ['Sources/**/*.swift', 'Sources/**/*.h']
  
  s.public_header_files = 'Sources/**/*.h'
end

