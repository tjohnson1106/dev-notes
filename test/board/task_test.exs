defmodule Board.TaskTest do
  use Board.DataCase

  alias Board.Task

  import Board.Fixtures,
    only: [
      list_fixture: 0,
      list_fixture: 1,
      user_fixture: 1
    ]

  @create_list_attrs %{name: "some list name"}
  @create_user_attrs %{username: "some username"}

  describe "lists" do
    alias Board.Task.List

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Task.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Task.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      user = user_fixture(@create_user_attrs)
      attrs = Map.put(@valid_attrs, :user_id, user.id)
      assert {:ok, %List{} = list} = Task.create_list(attrs)
      assert list.name == "some name"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      assert {:ok, %List{} = list} = Task.update_list(list, @update_attrs)
      assert list.name == "some updated name"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_list(list, @invalid_attrs)
      assert list == Task.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Task.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Task.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Task.change_list(list)
    end
  end

  describe "cards" do
    alias Board.Task.Card

    @valid_attrs %{details: "some details", title: "some title"}
    @update_attrs %{details: "some updated details", title: "some updated title"}
    @invalid_attrs %{details: nil, title: nil}

    def card_fixture(attrs \\ %{}) do
      user = user_fixture(@create_user_attrs)
      list = list_fixture(@create_list_attrs)

      {:ok, card} =
        attrs
        |> Map.put(:user_id, user.id)
        |> Map.put(:list_id, list.id)
        |> Enum.into(@valid_attrs)
        |> Task.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Task.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Task.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      user = user_fixture(@create_user_attrs)
      list = list_fixture(@create_list_attrs)

      attrs =
        Map.merge(@valid_attrs, %{
          user_id: user.id,
          list_id: list.id
        })

      assert {:ok, %Card{} = card} = Task.create_card(@valid_attrs)
      assert card.details == "some details"
      assert card.title == "some title"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, %Card{} = card} = Task.update_card(card, @update_attrs)
      assert card.details == "some updated details"
      assert card.title == "some updated title"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_card(card, @invalid_attrs)
      assert card == Task.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Task.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Task.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Task.change_card(card)
    end
  end
end
