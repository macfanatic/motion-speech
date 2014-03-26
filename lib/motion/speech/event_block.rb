module Motion
  module Speech
    class EventBlock

      Events = %w(start finish cancel pause).freeze

      Events.each do |method|
        define_method method do |*args, &block|
          if !block.nil?
            instance_variable_set("@#{method}_block", block)
          else
            instance_variable_get("@#{method}_block")
          end
        end
      end

      def call(event, speaker)
        block = send(event)
        block.call(speaker) unless block.nil?
      end
    end
  end
end
