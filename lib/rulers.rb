# frozen_string_literal: true

require_relative "rulers/version"
require "rulers/array"
require "rulers/average_two_numbers"
require "rulers/routing"

module Rulers
  # The main application class (for now, I guess)
  class Application
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      _text = controller.send(act)
      [200, { "Content-Type" => "text/html" }, ["Hello from Ruby on Rulers!"]]
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
