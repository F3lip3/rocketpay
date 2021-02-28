defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, return an user" do
      params = %{
        name: "Felipe",
        password: "123456",
        nickname: "ogbog",
        email: "felip3.humberto@gmail.com",
        age: 34
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Felipe", age: 34, id: ^user_id} = user
    end

    test "when params are invalid, return an error" do
      params = %{
        name: "Felipe",
        nickname: "ogbog",
        email: "felip3.humberto@gmail.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
