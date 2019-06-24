defmodule Board.Task.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :details, :string
    field :title, :string
    field :list_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :details])
    |> validate_required([:title, :details])
  end
end
