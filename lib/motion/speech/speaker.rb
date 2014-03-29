module Motion
  module Speech
    class Speaker
      attr_reader :options, :utterance

      MultipleCallsToSpeakError = Class.new(StandardError)

      def self.speak(*args, &block)
        new(*args, &block).speak
      end

      def initialize(speakable, options={}, &block)
        @options = options
        @utterance = Utterance.new(speakable, options)
        @spoken = false

        if block_given?
          if block.arity == 0
            events.finish &block
          elsif block.arity == 1
            block.call events
          else
            raise ArgumentError, 'block must accept either 0 or 1 arguments'
          end
        end
      end

      def speak
        raise MultipleCallsToSpeakError if @spoken

        synthesizer.speakUtterance utterance
        @spoken = true
        self
      end

      def pause(boundary)
        synthesizer.pauseSpeakingAtBoundary boundary_from_symbol(boundary)
      end

      def stop(boundary)
        synthesizer.stopSpeakingAtBoundary boundary_from_symbol(boundary)
      end

      def resume
        synthesizer.continueSpeaking
      end

      def paused?
        synthesizer.paused?
      end

      def speaking?
        synthesizer.speaking?
      end

      def message
        utterance.message
      end

      def synthesizer
        @synthesizer ||= AVSpeechSynthesizer.new.tap { |s| s.delegate = self }
      end

      private

      def speechSynthesizer(s, didFinishSpeechUtterance: utterance)
        events.call :finish, self
      end

      def speechSynthesizer(s, didStartSpeechUtterance: utterance)
        events.call :start, self
      end

      def speechSynthesizer(s, didCancelSpeechUtterance: utterance)
        events.call :cancel, self
      end

      def speechSynthesizer(s, didPauseSpeechUtterance: utterance)
        events.call :pause, self
      end

      def speechSynthesizer(s, didContinueSpeechUtterance: utterance)
        events.call :resume, self
      end

      def events
        @events ||= EventBlock.new
      end

      def boundary_from_symbol(sym)
        case sym
        when :word
          AVSpeechBoundaryWord
        when :immediate
          AVSpeechBoundaryImmediate
        when Fixnum
          sym
        end
      end
    end
  end
end
