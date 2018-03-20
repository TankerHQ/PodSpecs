Pod::Spec.new do |s|
  s.name             = 'Tanker'
  s.version          = '1.4.0-alpha-1'
  s.summary          = 'End to end encryption'

  s.description      = <<-DESC
Tanker is a end-to-end encryption SDK.

It's available for browsers, desktop, iOS and Android.
                       DESC

  s.homepage         = 'https://tanker.io'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Tanker developers'
  s.source           = { :http => "https://storage.tanker.io/ios/tanker-ios-sdk-#{s.version}.tar.gz" }

  s.ios.deployment_target = '9.0'

  s.dependency 'PromiseKit/Promise', '~> 1.7'
  s.dependency 'PromiseKit/When', '~> 1.7'
  s.source_files = 'Tanker/Classes/**/*'
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Tanker/vendor/include/**" }

  s.subspec 'libtanker' do |libtanker|

    # Get all .a from vendor/lib/
    all_libs = %w{
      vendor/lib/libboost_atomic.a
      vendor/lib/libboost_chrono.a
      vendor/lib/libboost_container.a
      vendor/lib/libboost_context.a
      vendor/lib/libboost_coroutine.a
      vendor/lib/libboost_date_time.a
      vendor/lib/libboost_exception.a
      vendor/lib/libboost_fiber.a
      vendor/lib/libboost_filesystem.a
      vendor/lib/libboost_graph.a
      vendor/lib/libboost_iostreams.a
      vendor/lib/libboost_log.a
      vendor/lib/libboost_log_setup.a
      vendor/lib/libboost_math_c99.a
      vendor/lib/libboost_math_c99f.a
      vendor/lib/libboost_math_c99l.a
      vendor/lib/libboost_prg_exec_monitor.a
      vendor/lib/libboost_program_options.a
      vendor/lib/libboost_random.a
      vendor/lib/libboost_serialization.a
      vendor/lib/libboost_signals.a
      vendor/lib/libboost_stacktrace_basic.a
      vendor/lib/libboost_stacktrace_noop.a
      vendor/lib/libboost_system.a
      vendor/lib/libboost_test_exec_monitor.a
      vendor/lib/libboost_thread.a
      vendor/lib/libboost_timer.a
      vendor/lib/libboost_type_erasure.a
      vendor/lib/libboost_unit_test_framework.a
      vendor/lib/libboost_wave.a
      vendor/lib/libboost_wserialization.a
      vendor/lib/libbz2.a
      vendor/lib/libcrypto.a
      vendor/lib/libcurl.a
      vendor/lib/libfmt.a
      vendor/lib/libmockaron.a
      vendor/lib/libsioclient_tls.a
      vendor/lib/libsodium.a
      vendor/lib/libsqlcipher.a
      vendor/lib/libsqlpp11-connector-sqlite3.a
      vendor/lib/libssl.a
      vendor/lib/libtankercrypto.a
      vendor/lib/libtanker.a
      vendor/lib/libtankercore.a
      vendor/lib/libtconcurrent.a
      vendor/lib/libtls.a
      vendor/lib/libtankerusertoken.a
      vendor/lib/libz.a
    }

    # Extract library name from full path:
    # path/to/libfoo.a -> foo
    extract_lib_name = lambda do |lib_path|
      res = File.basename(lib_path, ".a")
      res[3..-1]
    end

    libtanker.preserve_paths = 'vendor/lib/*.a', 'vendor/include/**/*.h', 'LICENSE'
    libtanker.vendored_libraries = all_libs
    libnames = all_libs.map { |lib| extract_lib_name.call(lib) }

    libtanker.libraries = libnames + ['c++', 'c++abi']
  end

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tanker/Tests/*.{h,m}'
    test_spec.dependency 'Specta'
    test_spec.dependency 'Expecta'
    test_spec.dependency 'PromiseKit/Hang', '~> 1.7'
  end

end
