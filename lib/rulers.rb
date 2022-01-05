# frozen_string_literal: true

require_relative "rulers/version"
require "rulers/array"
require "rulers/average_two_numbers"
require "rulers/routing"

module Rulers
  # The main application class (for now, I guess)
  class Application
    def call(env)
      return [404, { "Content-Type" => "text/html" }, []] if env["PATH_INFO"] == "/favicon.ico"

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
