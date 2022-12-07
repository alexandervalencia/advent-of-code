require 'byebug'

class CommunicationDevice
  PACKET_CHUNK_SIZE = 4

  def initialize(input)
    @datastream = input
  end

  def start_of_packet_position
    datastream.split("").each_cons(PACKET_CHUNK_SIZE) do |chunk|
      if (chunk == chunk.uniq)
        return datastream.index(chunk.join) + PACKET_CHUNK_SIZE
      end
    end
  end

  private

  attr_reader :datastream
end
