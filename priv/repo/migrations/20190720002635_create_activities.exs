defmodule Board.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :action, :string
      # create record
      add :user_id, references(:users, on_delete: :nilify_all)
      # card moves from list A to list B then list A is deleted ->
      # activity should not be deleted
      # if moved to list C we still want the record of it moving from A to B
      add :from_id, references(:lists, on_delete: :nilify_all)
      add :to_id, references(:lists, on_delete: :nilify_all)
      # of course if card is deleted so are activities
      add :card_id, references(:cards, on_delete: :delete_all)

      timestamps()
    end

    # unique not needed
    create index(:activities, [:user_id])
    create index(:activities, [:from_id])
    create index(:activities, [:to_id])
    create index(:activities, [:card_id])
  end
end
