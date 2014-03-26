module Motion
  module Speech
    class Speaker
      attr_reader :message, :options

      def self.speak(*args, &block)
        new(*args, &block).speak
      end

      def initialize(str, options={}, &block)
        @message, @options = str, options
        @configuration_block = block
      end

      def speak(&block)
        synthesizer.speakUtterance utterance
        self
      end

      def utterance
        return @utterance unless @utterance.nil?

        @utterance = AVSpeechUtterance.speechUtteranceWithString(message)
        @utterance.rate = options.fetch(:rate, 0.15)
        @utterance
      end

      def synthesizer
        @synthesizer ||= AVSpeechSynthesizer.new.tap { |s| s.delegate = self }
      end

      def config
        @configuration_block
      end

      def has_config?
        !config.nil?
      end

    end
  end
end
