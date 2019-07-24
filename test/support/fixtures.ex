defmodule Board.Fixtures do
  alias Board.{Accounts, Task}

  @create_card_attrs %{name: "some list name", position: 0}
  @create_list_attrs %{name: "some list name", position: 0}
  @create_user_attrs %{username: "some username"}

  def card_fixture(attrs \\ %{}) do
    user = get_or_create_user()
    list = list_fixture()

    {:ok, card} =
      attrs
      |> Map.put(:user, user.id)
      |> Map.put(:list_id, list.id)
      # TODO: warning: undefined module attribute @create_list_attrs, please remove access to @create_list_attrs or explicitly set it before access
      # test/support/fixtures.ex:15: Board.Fixtures (module)
      |> Enum.into(@create_card_attrs)
      |> Task.create_card()

    card
  end

  def list_fixture(attrs \\ %{}) do
    user = get_or_create_user()

    {:ok, card} =
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

  # tasks -> create card
  def create_card(_) do
    card = card_fixture(@create_card_attrs)
    {:ok, card: card}
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

  # last user if there is one
  # must be end of the module
  def get_or_create_user do
    case Elixir.List.last(Board.Accounts.list_users()) do
      nil ->
        user_fixture(@create_user_attrs)
    end
  end
end
