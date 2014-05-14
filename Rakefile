PROJECT_NAME = "DinasTutorial"
EXECUTABLE_NAME = "DinasTutorial"

CONFIGURATION = "Release"
SPECS_CONFIGURATION = "Debug"

SPECS_TARGET_NAME = "specs"
TARGET_NAME = "DinasTutorial"

PROJECT_ROOT = File.dirname(__FILE__)
BUILD_DIR = File.join(PROJECT_ROOT, "build")

SDK_VERSION = "7.0"

require 'pathname'
require 'tmpdir'

class CedarTargetSpecs
  def self.in_project_dir
    original_dir = Dir.pwd
    Dir.chdir(PROJECT_ROOT)

    yield

  ensure
    Dir.chdir(original_dir)
  end

  def self.deployment_target_sdk_version
    in_project_dir do
      `xcodebuild -showBuildSettings -target '#{self.specs_target_name}' | grep IPHONEOS_DEPLOYMENT_TARGET | awk '{print $3 }'`.strip
    end
  end

  def self.deployment_target_sdk_dir
    @sdk_dir ||= "#{xcode_developer_dir}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator#{deployment_target_sdk_version}.sdk"
  end

  # Xcode 4.3 stores its /Developer inside /Applications/Xcode.app, Xcode 4.2 stored it in /Developer
  def self.xcode_developer_dir
    `xcode-select -print-path`.strip
  end

  def self.build_dir(effective_platform_name)
    File.join(BUILD_DIR, SPECS_CONFIGURATION + effective_platform_name)
  end

  def self.is_run_unit_tests_deprecated?
    system("cat #{xcode_developer_dir}/Tools/RunUnitTests | grep -q 'RunUnitTests is obsolete.'")
  end

  def self.system_or_exit(cmd, stdout = nil)
    puts "Executing #{cmd}"
    cmd += " >#{stdout}" if stdout
    system(cmd) or raise "******** Build failed ********"
  end

  def self.run_cmd_and_grep_for_failure(cmd)
    puts "Executing #{cmd}"
    puts result = %x[#{cmd} 2>&1]
    if result.index(/Test Case.*failed/)
      exit(1)
    else
      exit(0)
    end
  end

  def self.with_env_vars(env_vars)
    old_values = {}
    env_vars.each do |key,new_value|
      old_values[key] = ENV[key]
      ENV[key] = new_value
    end

    yield

    env_vars.each_key do |key|
      ENV[key] = old_values[key]
    end
  end

  def self.output_file(target)
    output_dir = if ENV['IS_CI_BOX']
                   ENV['CC_BUILD_ARTIFACTS']
                 else
                   Dir.mkdir(BUILD_DIR) unless File.exists?(BUILD_DIR)
                   BUILD_DIR
                 end

    output_file = File.join(output_dir, "#{target}.output")
    puts "Output: #{output_file}"
    output_file
  end

  def self.kill_simulator
    system %Q[killall -m -KILL "gdb"]
    system %Q[killall -m -KILL "otest"]
    system %Q[killall -m -KILL "iPhone Simulator"]
  end

  def self.build_app_for_specs
    in_project_dir do
      system_or_exit "xcodebuild -scheme '#{self.app_target_name}' -target '#{self.app_target_name}' -configuration #{SPECS_CONFIGURATION} -sdk iphonesimulator#{deployment_target_sdk_version} build ARCHS=i386 TEST_AFTER_BUILD=NO GCC_SYMBOLS_PRIVATE_EXTERN=NO SYMROOT='#{BUILD_DIR}' -derivedDataPath '#{BUILD_DIR}'", output_file("#{self.to_s.sub("Specs", "").downcase}-app-build")
    end
  end

  def self.build_specs
    in_project_dir do
      system_or_exit "xcodebuild -scheme '#{self.app_target_name}' -target '#{self.specs_target_name}' -configuration #{SPECS_CONFIGURATION} -sdk iphonesimulator#{deployment_target_sdk_version} build ARCHS=i386 GCC_SYMBOLS_PRIVATE_EXTERN=NO TEST_AFTER_BUILD=NO SYMROOT='#{BUILD_DIR}' -derivedDataPath '#{BUILD_DIR}'", output_file("#{self.to_s.sub("Specs", "").downcase}-specs-build")
    end
  end

  def self.run_specs_bundle_without_environment_variables
    env_vars = {
      "CEDAR_REPORTER_CLASS" => "CDRColorizedReporter",
    }

    with_env_vars(env_vars) do
      in_project_dir do
        system_or_exit "xcodebuild test -scheme '#{self.app_target_name}' -configuration #{SPECS_CONFIGURATION} -destination 'OS=#{deployment_target_sdk_version},name=iPhone Retina (3.5-inch)' ARCHS=i386 SYMROOT='#{BUILD_DIR}' -derivedDataPath '#{BUILD_DIR}'"
      end
    end
  end

  def self.run_specs_bundle_with_environment_variables
    env_vars = {
      "DYLD_ROOT_PATH" => deployment_target_sdk_dir,
      "DYLD_INSERT_LIBRARIES" => "#{xcode_developer_dir}/Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
      "DYLD_FALLBACK_LIBRARY_PATH" => deployment_target_sdk_dir,
      "XCInjectBundle" => "#{File.join(build_dir("-iphonesimulator"), "'#{self.specs_target_name}.octest")}'",
      "XCInjectBundleInto" => "#{File.join(build_dir("-iphonesimulator"), "'#{self.app_target_name}.app/#{self.app_target_name}'")}",
      "IPHONE_SIMULATOR_ROOT" => deployment_target_sdk_dir,
      "CFFIXED_USER_HOME" => Dir.tmpdir,
      "CEDAR_HEADLESS_SPECS" => "1",
      "CEDAR_REPORTER_CLASS" => "CDRColorizedReporter",
    }

    with_env_vars(env_vars) do
      system_or_exit "#{File.join(build_dir("-iphonesimulator"), "'#{self.app_target_name}.app/#{self.app_target_name}")}' -RegisterForSystemEvents -SenTest All"
    end
  end

  def self.run_specs_bundle
    run_specs_bundle_without_environment_variables
  end
end

class Target < CedarTargetSpecs
  def self.specs_target_name
    SPECS_TARGET_NAME
  end

  def self.app_target_name
    TARGET_NAME
  end
end

=begin ************************************************************************

RAKE TASKS

=end **************************************************************************

task :clean => [:clean_precompiled_headers, :clean_specs_bundle]
task :default => [:trim_whitespace, :specs]
task :cruise => [:clean, :specs]
task :tw => [:trim_whitespace]

desc "Trim whitespace"
task :trim_whitespace do
  CedarTargetSpecs.system_or_exit %Q[git status --porcelain | awk '{if ($1 != "D" && $1 != "R") print $NF}' | grep -e '.*\.[cmh]$' | xargs sed -i '' -e 's/	/    /g;s/ *$//g;']
end

desc "Remove any focus from specs"
task :nof => :trim_whitespace do
  CedarTargetSpecs.system_or_exit %Q[ grep -l -r -e "\\(fit\\|fdescribe\\|fcontext\\)" Specs | grep -v 'Specs/Frameworks' | xargs -I{} sed -i '' -e 's/fit\(@/it\(@/g;' -e 's/fdescribe\(@/describe\(@/g;' -e 's/fcontext\(@/context\(@/g;' "{}" ]
end

desc "Clean the Shared Precompiled Headers"
task :clean_precompiled_headers do
  CedarTargetSpecs.system_or_exit "rm -rf /var/folders/*/*/C/com.apple.DeveloperTools/*/Xcode/SharedPrecompiledHeaders"
end

desc "Clean build directory"
task :clean_specs_bundle do
  CedarTargetSpecs.system_or_exit "rm -rf #{BUILD_DIR}/*", CedarTargetSpecs.output_file("clean")
end

desc "Build Specs Bundle"
task :build_core_specs do
  Target.kill_simulator
  Target.build_app_for_specs
  Target.build_specs
end

desc "Run Specs Bundle"
task :specs => :build_core_specs do
  Target.run_specs_bundle
end
