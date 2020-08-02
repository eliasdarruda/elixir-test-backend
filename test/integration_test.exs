defmodule IntegrationTest do
  use ExUnit.Case
  use Timex

  test "process order integration (w/ HTTP request)" do
    res = OrderJob.init()

    assert res == :ok
  end

  test "send processed order with invalid fields to api integrated in original api" do
    container = %DependencyContainer{}

    processedOrder =
      Repository.ExternalApiRepositoryProtocol.fetchPurchaseOrder(container)
      |> Services.ProcessingService.processOrder()

    assert_raise RuntimeError, fn ->
      %{processedOrder | externalCode: nil}
      |> Services.ProcessingService.saveProcessedOrder(container)
    end
  end
end
