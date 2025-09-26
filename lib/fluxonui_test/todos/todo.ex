defmodule FluxonUITest.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :description, :string
    field :due, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:description, :due])
    |> validate_required([:description, :due])
  end
end
