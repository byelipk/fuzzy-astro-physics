defmodule Greeter do

  # A glorious pipeline of hello functions

  def hello(names, country \\ "usa")

  def hello(names, country) when is_list(names) do
    names
      |> Enum.join(", ")
      |> hello(country)
  end

  def hello(names, country) when is_binary(names) do
    phrase(country) <> names
  end

  defp phrase("usa"), do: "Hello, "
  defp phrase("mex"), do: "Hola, "
  defp phrase("fr"),  do: "Bonjour, "

  # # a default function head
  # def function(%{key: "value"}), do: function(, some_option: "default value")
  #
  # # handle errors when part of a pipe set
  # def function(%{error: err}), do: handle_error(err)
  #
  # # the main function head
  # def function(%{key: "value"}, options) do
  #   # body
  #   value   |> IO.inspect
  #   options |> IO.inspect
  # end
  #
  # def handle_error(err), do: err |> IO.inspect
end
