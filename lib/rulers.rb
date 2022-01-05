# frozen_string_literal: true

require_relative "rulers/version"
require "rulers/array"
require "rulers/average_two_numbers"

module Rulers
  # The main application class (for now, I guess)
  class Application
    def call(_env)
      `echo debug > debug.txt`
      [200, { "Content-Type" => "text/html" }, ["Hello from Ruby on Rulers!"]]
    end
  end
end
