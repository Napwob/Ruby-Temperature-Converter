# frozen_string_literal: true

require_relative './states/read_first_scale'
require_relative './states/storage'

class Program
  def execute
    puts "To exit program enter 'e'"
    @state = States::ReadFirstScale.new
    loop do
      @state.execute
      @state = @state.next
    end
  end
end
