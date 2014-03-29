module Motion
  module Speech
    class Utterance < AVSpeechUtterance

      def initialize(speakable, options={})
        self.message = speakable
        self.rate = options.fetch(:rate, 0.15)
        self.pitch = options.fetch(:pitch, pitch)
        self.voice = options.fetch(:voice, nil)
        self.volume = options.fetch(:volume, volume)
      end

      def setSpeechString(speakable)
        super string_from_speakable(speakable)
      end

      def setRate(multiplier)
        super rate_for_symbol_or_float(multiplier)
      end

      alias_method :message, :speechString
      alias_method :message=, :setSpeechString
      alias_method :pitch, :pitchMultiplier
      alias_method :pitch=, :setPitchMultiplier
      alias_method :rate=, :setRate

      private

      def string_from_speakable(speakable)
        if speakable.respond_to?(:to_speakable)
          speakable.to_speakable
        else
          speakable
        end
      end

      def rate_for_symbol_or_float(rate)
        case rate
        when :maximum
          AVSpeechUtteranceMaximumSpeechRate
        when :minimum
          AVSpeechUtteranceMinimumSpeechRate
        when :default
          AVSpeechUtteranceDefaultSpeechRate
        when Fixnum, Float
          rate.to_f
        else
          raise ArgumentError, "invalid rate given: '#{rate}'"
        end
      end

    end
  end
end
