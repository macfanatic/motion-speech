module Motion
  module Speech
    class Utterance < AVSpeechUtterance

      alias_method :message, :speechString
      alias_method :message=, :setSpeechString

      def initialize(message, options={})
        self.message = message
        self.rate = options.fetch(:rate, 0.15)
      end

    end
  end
end
