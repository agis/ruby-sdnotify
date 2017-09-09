require "socket"

module SdDaemon
  READY     = "READY=1"
  RELOADING = "RELOADING=1"
  STOPPING  = "STOPPING=1"
  WATCHDOG  = "WATCHDOG=1"
  FDSTORE   = "FDSTORE=1"

  def self.notify(state, unset_env=false)
    sock = ENV["NOTIFY_SOCKET"]

    return false if !sock

    ENV.delete("NOTIFY_SOCKET") if unset_env

    begin
      sock = Addrinfo.unix(sock, :DGRAM).connect
      sock.close_on_exec = true
      sock.write(state)
    ensure
      sock.close
    end
  end

  def self.notify_ready(unset_env=false)
    notify(READY, unset_env)
  end

  def self.notify_reloading(unset_env=false)
    notify(RELOADING, unset_env)
  end

  def self.notify_stopping(unset_env=false)
    notify(STOPPING, unset_env)
  end

  def self.notify_status(status, unset_env=false)
    notify("STATUS=#{status}", unset_env)
  end

  def self.notify_errno(errno, unset_env=false)
    notify("ERRNO=#{errno}", unset_env)
  end

  def self.notify_mainpid(pid, unset_env=false)
    notify("MAINPID#{pid}", unset_env)
  end

  def self.notify_watchdog(unset_env=false)
    notify(WATCHDOG, unset_env)
  end

  def self.notify_fdstore(unset_env=false)
    notify(FDSTORE, unset_env)
  end
end
