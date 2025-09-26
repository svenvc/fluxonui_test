defmodule FluxonUITest.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :description, :string
      add :due, :date

      timestamps(type: :utc_datetime)
    end
  end
end
