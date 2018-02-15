Pod::Spec.new do |s|
  s.name             = 'KRCMulticastDelegate'
  s.version          = '0.1.0'
  s.summary          = 'KRCMulticastDelegate - A linked list of delegates, also called an invokation list.'

  s.description      = <<-DESC
KRCMulticastDelegate - A linked list of delegates, also called an invokation list.

- When a multicast delegate is invoked, the delegates in the list are called synchronously in the order in which they've been added to the delegate table.

- Delegate invocation will run on the caller's thread.
                       DESC

  s.homepage         = 'https://github.com/kaosdg/MulticastDelegate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Karl Catigbe' => 'spam@gmail.com' }
  s.source           = { :git => 'https://github.com/kaosdg/MulticastDelegate.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.0'
  s.source_files = ['Sources/**/*.swift', 'Sources/**/*.h']
  
  s.public_header_files = 'Sources/**/*.h'
end

