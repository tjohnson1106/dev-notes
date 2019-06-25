defmodule Board.Task.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :name, :string
    belongs_to :user, Board.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
