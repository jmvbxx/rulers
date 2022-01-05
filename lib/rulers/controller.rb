# frozen_string_literal: true

require "erubis"

# This is the first controller class
module Rulers
  class Controller
    def initialize(env)
      @env = env
    end

    attr_reader :env
  end
end
