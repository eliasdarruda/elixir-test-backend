defimpl Providers.OrdersApiProviderProtocol, for: DependencyContainer do
  use Timex

  @base_url "delivery-center-recruitment-ap.herokuapp.com"
  @base_port 443
  @base_service :https

  def post(_, path, data) do
    {:ok, conn} = Mint.HTTP.connect(@base_service, @base_url, @base_port)

    {:ok, conn, request_ref} =
      Mint.HTTP.request(
        conn,
        "POST",
        path,
        [formatSentHeader()],
        Jason.encode!(data)
      )

    receive do
      message ->
        {_, _, responses} = Mint.HTTP.stream(conn, message)

        case List.first(responses) do
          {:status, ^request_ref, 200} -> :ok
          {:status, ^request_ref, 400} -> List.keyfind(responses, :data, 0) |> elem(2) |> raise
        end
    end
  end

  def formatSentHeader do
    t = Timex.now()
    {:ok, details} = Timex.format(t, "%H:%M - %y/%m/%d", :strftime)
    {"X-Sent", details}
  end
end
