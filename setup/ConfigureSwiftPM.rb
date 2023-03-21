module Pod

  class ConfigureSwiftPM
    attr_reader :configurator

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @configurator = options.fetch(:configurator)
    end

    def perform
      framework = configurator.ask_with_answers("Which testing frameworks will you use", ["Quick", "None"]).to_sym
      case framework
        when :quick
          configurator.add_pod_to_podfile "Quick', '~> 2.2.0"
          configurator.add_pod_to_podfile "Nimble', '~> 10.0.0"
          configurator.set_test_framework "quick", "swift", "swift"

        when :none
          configurator.set_test_framework "xctest", "swift", "swift"
      end

      Pod::ProjectManipulator.new({
        :configurator => @configurator,
        :xcodeproj_path => "templates/swift-pm/Example/PROJECT.xcodeproj",
        :platform => :ios,
        :remove_demo_project => true,
        :prefix => ""
      }).run

      # There has to be a single file in the Classes dir
      # or a framework won't be created
      puts `pwd`
      `touch Sources/#{@configurator.pod_name}/#{@configurator.pod_name}.swift`

      `mv ./templates/swift-pm/* ./`
    end
  end

end
