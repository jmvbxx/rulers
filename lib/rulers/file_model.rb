# frozen_string_literal: true

require "multi_json"

module Rulers
  # Model module
  module Model
    # FileModel class
    class FileModel
      def initialize(filename)
        @filename = filename

        # If filename is 'dir/37.json', @id is 37
        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i
        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def self.find(id)
        id = id.to_i
        @dm_style_cache ||= {}
        begin
          return @dm_style_cache[id] if @dm_style_cache[id]

          m = FileModel.new("db/quotes/#{id}.json")
          @dm_style_cache[id] = m
          m
        rescue StandardError
          nil
        end
      end

      def self.all
        files = Dir["db/quotes/*.json"]
        files.map { |f| FileModel.new f }
      end

      # rubocop:disable Metrics/AbcSize
      def self.create(attrs)
        hash = {}
        hash["submitter"] = attrs["submitter"] || ""
        hash["quote"] = attrs["quote"] || ""
        hash["attribution"] = attrs["attribution"] || ""

        files = Dir["db/quotes/*.json"]
        names = files.map { |f| File.split(f)[-1] }
        highest = names.map(&:to_i).max
        id = highest + 1

        File.open("db/quotes/#{id}.json", "w") do |f|
          f.write <<~TEMPLATE
            {
              "submitter": "#{hash["submitter"]}",
              "quote": "#{hash["quote"]}",
              "attribution": "#{hash["attribution"]}"
            }
          TEMPLATE
        end

        FileModel.new "db/quotes/#{id}.json"
      end
      # rubocop:enable Metrics/AbcSize

      def self.find_all_by_attrib(attrib, value)
        id = 1
        results = []
        loop do
          m = FileModel.find(id)
          return results unless m

          results.push(m) if m[attrib] == value
          id += 1
        end
      end

      def self.method_mission(method, *args)
        if method.to_s[0..11] == "find_all_by_"
          attrib = method.to_s[12..-1]
          return find_all_by_attrib attrib, args[0]
        end
      end
      
      def save
        File.open(@filename, "w") do |f|
          f.write <<~TEMPLATE
            {
              "submitter": "#{@hash["submitter"]}",
              "quote": "#{@hash["quote"]}",
              "attribution": "#{@hash["attribution"]}"#{" "}
            }
          TEMPLATE
        end
      end
    end
  end
end
