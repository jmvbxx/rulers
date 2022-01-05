# frozen_string_literal: true

require_relative "rulers/version"
require "rulers/array"
require "rulers/average_two_numbers"
require "rulers/routing"

module Rulers
  # The main application class (for now, I guess)
  class Application
    def call(_env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, { "Content-Type" => "text/html" }, ["Hello from Ruby on Rulers!"]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
