defmodule Board.Task.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  #  belongs to card and user

  schema "comments" do
    field :body, :string

    field :card_id, :id
    field :user_id, :id
    belongs_to :card, Board.Task.Card
    belongs_to :user, Board.Accounts.Card

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :card_id, :user_id])
    |> validate_required([:body, :card_id, :user_id])
  end
end
