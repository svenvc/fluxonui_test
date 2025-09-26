defmodule FluxonUITest.Repo do
  use Ecto.Repo,
    otp_app: :fluxonui_test,
    adapter: Ecto.Adapters.Postgres
end
