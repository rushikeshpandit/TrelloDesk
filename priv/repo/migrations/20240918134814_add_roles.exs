defmodule TrelloDesk.Repo.Migrations.AddRoles do
  use Ecto.Migration

  def change do
    query = "CREATE TYPE roles as ENUM('USER', 'ADMIN')"
    drop = "DROP TYPE roles"

    execute(query, drop)

    alter table(:users) do
      add :role, :roles, defaults: "USER", null: false
    end
  end
end
