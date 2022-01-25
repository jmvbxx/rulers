# frozen_string_literal: true

require "rulers/version"
require "rulers/array"
require "rulers/average_two_numbers"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"
require "rulers/file_model"

module Rulers
  # The main application class (for now, I guess)
  class Application
    def call(env)
      case env["PATH_INFO"]
      when "/favicon.ico"
        [404, { "Content-Type" => "text/html" }, []]
      when "/test"
        [200, { "Content-Type" => "text/html" }, [File.read("test/index.html")]]
      when "/search"
        [301, { "Location" => "https://google.com" }, []]
      else
        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(act)
        r = controller.get_response
        if r
          [r.status, r.headers, [r.body].flatten]
        else
          [200, { "Content-Type" => "text/html" }, [text]]
        end
      end
    end
  end
end
