# frozen_string_literal: true

SCALES = %w[K C F].freeze

module States
  class Storage
    attr_reader :context

    def initialize(context = {})
      @context = context
    end
  end
end
