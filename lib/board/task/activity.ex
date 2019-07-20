defmodule Board.Task.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  # TODO: update activities schema 071920192054

  schema "activities" do
    field :action, :string
    field :user_id, :id
    field :from_id, :id
    field :to_id, :id
    field :card_id, :id

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:action])
    |> validate_required([:action])
  end
end
