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

    bytes_sent = SdNotify.ready

    assert_equal(socket_message, "READY=1")
    assert_equal(ENV["NOTIFY_SOCKET"], @sockaddr)
    assert_equal(bytes_sent, 7)
  end

  def test_sd_notify_ready_unset
    setup_socket

    SdNotify.ready(true)

    assert_equal(socket_message, "READY=1")
    assert_nil(ENV["NOTIFY_SOCKET"])
  end

  def test_sd_notify_watchdog_disabled
    setup_socket

    refute(SdNotify.watchdog?)
  end

  def test_sd_notify_watchdog_enabled
    ENV["WATCHDOG_USEC"] = "5_000_000"
    ENV["WATCHDOG_PID"] = $$.to_s
    setup_socket

    assert(SdNotify.watchdog?)
  end

  def test_sd_notify_watchdog_enabled_for_a_different_process
    ENV["WATCHDOG_USEC"] = "5_000_000"
    ENV["WATCHDOG_PID"] = ($$ + 1).to_s
    setup_socket

    refute(SdNotify.watchdog?)
  end

  def test_sd_notify_watchdog_interval_disabled
    setup_socket

    assert_nil(SdNotify.watchdog_interval)
  end

  def test_sd_notify_watchdog_interval_enabled
    ENV["WATCHDOG_USEC"] = "5_000_000"
    ENV["WATCHDOG_PID"] = $$.to_s
    setup_socket

    assert_equal(5.0, SdNotify.watchdog_interval)
  end

  def teardown
    @socket.close if @socket
    File.unlink(@sockaddr) if @sockaddr
    @socket = nil
    @sockaddr = nil
    ENV.delete("NOTIFY_SOCKET")
    ENV.delete("WATCHDOG_USEC")
    ENV.delete("WATCHDOG_PID")
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
