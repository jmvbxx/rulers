# frozen_string_literal: true

require "rulers/version"
require "rulers/array"
require "rulers/average_two_numbers"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"

module Rulers
  # The main application class (for now, I guess)
  class Application
    def call(env)
      return [404, { "Content-Type" => "text/html" }, []] if env["PATH_INFO"] == "/favicon.ico"
      return [301, { "Location" => "https://google.com" }, []] if env["PATH_INFO"] == "/search"

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, { "Content-Type" => "text/html" }, [text]]
    end
  end

  # This is the first controller class
  class Controller
    def initialize(env)
      @env = env
    end

    attr_reader :env
  end
end
