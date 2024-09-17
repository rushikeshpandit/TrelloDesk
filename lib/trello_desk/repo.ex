defmodule TrelloDesk.Repo do
  use Ecto.Repo,
    otp_app: :trello_desk,
    adapter: Ecto.Adapters.Postgres
end
