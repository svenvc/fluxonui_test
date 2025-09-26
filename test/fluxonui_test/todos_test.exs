defmodule FluxonUITest.TodosTest do
  use FluxonUITest.DataCase

  alias FluxonUITest.Todos

  describe "todos" do
    alias FluxonUITest.Todos.Todo

    import FluxonUITest.TodosFixtures

    @invalid_attrs %{description: nil, due: nil}

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Todos.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Todos.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      valid_attrs = %{description: "some description", due: ~D[2025-09-25]}

      assert {:ok, %Todo{} = todo} = Todos.create_todo(valid_attrs)
      assert todo.description == "some description"
      assert todo.due == ~D[2025-09-25]
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      update_attrs = %{description: "some updated description", due: ~D[2025-09-26]}

      assert {:ok, %Todo{} = todo} = Todos.update_todo(todo, update_attrs)
      assert todo.description == "some updated description"
      assert todo.due == ~D[2025-09-26]
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_todo(todo, @invalid_attrs)
      assert todo == Todos.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Todos.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Todos.change_todo(todo)
    end
  end
end
