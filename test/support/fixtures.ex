defmodule Board.Fixtures do
  alias Board.Accounts

  @create_list_attrs %{name: "some list name", position: 0}
  @create_user_attrs %{username: "some username"}

  def list_fixture(attrs \\ %{}) do
    user =
      case Elixir.List.last(Board.Accounts.list_users()) do
        nil ->
          user_fixture(@create_user_attrs)

        existing_user ->
          existing_user
      end

    {:ok, list} =
      attrs
      |> Map.put(:user_id, user.id)
      |> Enum.into(@create_list_attrs)
      |> Task.create_list()

    list
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@create_user_attrs)
      |> Accounts.create_user()

    user
  end

  # tasks -> create list

  def create_list(_) do
    list = list_fixture(@create_list_attrs)
    {:ok, list: list}
  end

  # tasks -> create user

  def create_user(_) do
    user = user_fixture(@create_user_attrs)
    {:ok, user: user}
  end
end
