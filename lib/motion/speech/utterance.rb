module Motion
  module Speech
    class Utterance < AVSpeechUtterance

      def initialize(speakable, options={})
        self.message = speakable
        self.rate = options.fetch(:rate, 0.15)
      end

      def setSpeechString(speakable)
        super string_from_speakable(speakable)
      end

      alias_method :message, :speechString
      alias_method :message=, :setSpeechString

      private

      def string_from_speakable(speakable)
        if speakable.respond_to?(:to_speakable)
          speakable.to_speakable
        else
          speakable
        end
      end

    end
  end
end
