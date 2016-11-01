require_relative "dependencies"

class App < Sinatra::Base
  get "/" do
    "I am Groot"
  end

  post "/api/echo" do
    payload = JSON.parse(request.body.read)
    # [418, payload.to_json]
    payload.to_json
  end

  get "/q/employees" do
    ::Employee.all.to_json
  end

  get "/q/employee" do
    int_id = params["id"].to_i
    ::Employee.find(int_id).to_json
  end

  run! if app_file == $PROGRAM_NAME
end
