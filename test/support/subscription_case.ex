defmodule DivulgaIoWeb.SubscriptionCase do
  @moduledoc """
  This module defines the test case to be used by subscription tests
  """
  require Phoenix.ChannelTest
  use ExUnit.CaseTemplate

  using do
    quote do
      use DivulgaIoWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest, schema: DivulgaIoWeb.Schema

      setup do
        {:ok, socket} = Phoenix.ChannelTest.connect(DivulgaIoWeb.UserSocket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)

        {:ok, socket: socket}
      end
    end
  end
end
