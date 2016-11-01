require_relative "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def test_declares_its_name
    response = get "/"
    assert response.ok?
    assert_equal "I am Groot", response.body
  end

  def test_it_handles_and_returns_json
    hash = { name: "bob" }
    response = post("/api/echo", hash.to_json, { "CONTENT_TYPE" => "application/json" })

    assert response.ok?
    payload = JSON.parse(response.body)
    assert_equal({ "name" => "bob" }, payload)
  end

  def test_can_get_all_employees
    response = get "/q/employees"
    assert response.ok?
    hash_response = JSON.parse(response.body)
    assert_equal "Jerkface", hash_response[0]["name"]
    assert_equal 39, hash_response.size
  end

  def test_read_single_employee
    response = get "/q/employee", id: 10
    assert response.ok?
  end
end
