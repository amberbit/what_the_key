defmodule WhatTheKey do
  defp fetch_key(username) do
    with %HTTPoison.Response{status_code: 200, body: body} <- http_client.get!(url(username)),
         list <- Poison.decode!(body),
         [first_key | _] <- list,
         %{"key" =>  key} <- first_key
    do
      {:ok, key}
    else
      _err -> {:error, "Key not found"}
    end
  end

  defp http_client do
    Application.get_env(:what_the_key, :http_client) || HTTPoison
  end

  @doc ~S"""
     Converts username to API endpoint URL

     ## Examples:

       iex> WhatTheKey.url("hubertlepicki")
       "https://api.github.com/users/hubertlepicki/keys"

  """
  def url(username) do
    "https://api.github.com/users/#{username}/keys"
  end

  def main(username, system_mod \\ System)
  def main([username], system_mod) do
    case fetch_key(username) do
      {:ok, key} ->
        IO.puts key
        system_mod.halt(0)

      {:error, message} ->
        IO.puts message
        system_mod.halt(1)
    end
  end

  def main(_, system_mod) do
    IO.puts "Usage: ./what_the_key github_username"
    system_mod.halt(1)
  end
end
