require 'byebug'

class CommunicationDevice
  PACKET_CHUNK_SIZE = 4
  MESSAGE_CHUNK_SIZE = 14

  def initialize(input)
    @datastream = input
  end

  def start_of_packet_position
    find_unique_datastream_position(PACKET_CHUNK_SIZE)
  end

  def start_of_message_position
    find_unique_datastream_position(MESSAGE_CHUNK_SIZE)
  end

  private

  attr_reader :datastream

  def find_unique_datastream_position(chunk_size)
    datastream.split("").each_cons(chunk_size) do |chunk|
      if (chunk == chunk.uniq)
        return datastream.index(chunk.join) + chunk_size
      end
    end
  end
end
