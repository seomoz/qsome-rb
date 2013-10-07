# Encoding: utf-8

require 'qless/lua_script'

module Qsome
  # A wrapper for all of our lua script access
  class LuaScript < Qless::LuaScript
    SCRIPT_ROOT = File.expand_path('../lua', __FILE__)

    # Get contents relative to qsome's stuff, not qless.
    def script_contents
      @script_contents ||= File.read(File.join(SCRIPT_ROOT, "#{@name}.lua"))
    end
  end
end
