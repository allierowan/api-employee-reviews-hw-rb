require_relative "dependencies"

class App < Sinatra::Base

  get "/q/employees" do
    # binding.pry
    ::Employee.all.to_json
  end

  get "/q/employees_where" do
    query = params.keys & Employee.attribute_names
    ::Employee.where(query).to_json
  end

  get "/q/employee" do
    int_id = params["id"].to_i
    ::Employee.find(int_id).to_json
  end

  post "/p/employee" do
    input = request.body.read
    unless input.empty?
      input_hash = JSON.parse(input)
      params.merge!(input_hash)
    end
    content_type("application/json")
    ::Employee.create!(department_id: params["department_id"], name: params["name"], email: params["email"], salary: params["salary"], review: params["review"], satisfactory: params["satisfactory"], phone: params["phone"])
  end

  delete "/d/employee" do
    ::Employee.find(params["id"]).destroy
  end

  patch "/u/employee" do
    ::Employee.find(params["id"]).update(name: params["new_name"])
  end

  run! if app_file == $PROGRAM_NAME
end
