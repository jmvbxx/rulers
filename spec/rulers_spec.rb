# frozen_string_literal: true

RSpec.describe Rulers do
  let(:app) { Rulers::Application.new }
  let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/test" } }
  let(:response) { app.call(env) }
  let(:status) { response[0] }
  let(:body) { response[2][0] }

  it "has a version number" do
    expect(Rulers::VERSION).not_to be nil
  end

  it "returns http success" do
    expect(status).to eq 200
  end

  it "returns body" do
    expect(body).to eq "test"
  end
end
