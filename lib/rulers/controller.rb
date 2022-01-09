# frozen_string_literal: true

require "erubis"
require "rulers/file_model"

module Rulers
  # This is the first controller class
  class Controller
    include Rulers::Model
    def initialize(env)
      @env = env
    end

    attr_reader :env

    def render(view_name, locals = {})
      filename = File.join "app", "views",
                           controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(env: env)
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, "")
      Rulers.to_underscore klass
    end
  end
end
