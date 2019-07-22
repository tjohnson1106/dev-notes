defmodule Board.Task.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :action, :string
    belongs_to :card, Board.Task.Card
    belongs_to :user, Board.Accounts.Card
    field :from_id, :id
    field :to_id, :id

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [
      :action,
      # from comment schema
      :card_id,
      :from_id,
      :from_id,
      :to_id,
      :user_id
    ])
    |> validate_required([:action, :card_id, :user_id])
  end
end
