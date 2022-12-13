require "json"

module Medup
  class Post
    @[JSON::Field(ignore: true)]
    property ctx : ::Medup::Context = ::Medup::Context.new

    @[JSON::Field(ignore: true)]
    property raw : String = ""
    property raw_payload : String = ""

    property id : Int32?
    property slug : String = ""
    property created_at : Time = Time.utc

    def self.from_json(raw : String, raw_payload : String = "")
      parser = JSON::PullParser.new(raw)
      instance = new(parser)
      instance.raw = raw
      instance.raw_payload = raw_payload
      instance
    end

    def to_pretty_json
      return "" if @raw == ""
      JSON.parse(@raw).to_pretty_json
    end

    def to_pretty_full_payload_json
      return "" if @raw_payload == ""
      JSON.parse(@raw_payload).to_pretty_json
    end

    def to_md
      content, assets = "", Hash(String, String).new
      return content, assets
    end
  end
end
