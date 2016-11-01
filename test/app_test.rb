require_relative "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def setup
    ::Employee.delete_all
    Employee.create!(name: "Kvothe", phone: "123-456-7891")
    Employee.create!(name: "Sim", email: "sim@theuniversity.com")
    Employee.create!(name: "Wil", salary: 80000)
  end

  def test_can_get_all_employees
    response = get "/q/employees"
    assert response.ok?
    hash_response = JSON.parse(response.body)
    assert_equal "Kvothe", hash_response[0]["name"]
    assert_equal 3, hash_response.size
  end

  def test_read_single_employee
    tempi = ::Employee.create!(name: "Tempi")
    emp_id = tempi.id
    response = get "/q/employee", id: emp_id
    assert response.ok?
    assert_equal "Tempi", JSON.parse(response.body)["name"]
  end

  def test_can_create_an_employee
    post("/p/employee", {name: "Deoch", email: "deoch@theeolian.com"}.to_json)
    deoch = ::Employee.where(email: "deoch@theeolian.com").first
    assert_equal "Deoch", deoch.name
  end

  def test_can_delete_an_employee
    deoch = ::Employee.create!(name: "Deoch")
    delete("/d/employee", {id: deoch.id})
    assert_raises do
      ::Employee.find(deoch.id)
    end
  end

  def test_can_change_an_employees_name
    deoch = ::Employee.create!(name: "Deoch")
    patch("u/employee", {id: deoch.id, new_name: "Elodin"})
    assert_equal ::Employee.where(name: "Elodin").first.id, deoch.id
  end
end
