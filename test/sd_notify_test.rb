# frozen_string_literal: true

require "minitest/autorun"
require "sd_notify"
require "socket"

class SdNotifyTest < Minitest::Test
  def test_nil_socket
    ENV["NOTIFY_SOCKET"] = nil

    assert_nil(SdNotify.ready)
  end

  def test_sd_notify_ready
    setup_socket

    SdNotify.ready

    assert_equal(socket_message, "READY=1")
    assert_equal(ENV["NOTIFY_SOCKET"], @sockaddr)
  end

  def test_sd_notify_ready_unset
    setup_socket

    SdNotify.ready(true)

    assert_equal(socket_message, "READY=1")
    assert_nil(ENV["NOTIFY_SOCKET"])
  end

  def teardown
    @socket&.close
    File.unlink(@sockaddr) if @sockaddr
    @socket = nil
    @sockaddr = nil
  end

  private

  def setup_socket
    ::Dir::Tmpname.create("test_socket") do |sockaddr|
      @sockaddr = sockaddr
      @socket = Socket.new(:UNIX, :DGRAM, 0)
      socket_ai = Addrinfo.unix(sockaddr)
      @socket.bind(socket_ai)
      ENV["NOTIFY_SOCKET"] = sockaddr
    end
  end

  def socket_message
    @socket.recvfrom(10)[0]
  end
end
