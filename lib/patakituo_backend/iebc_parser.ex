defmodule PatakituoBackend.IebcParser do
  @moduledoc"""
  Module for parsing IEBC data from HTML content
  """

  def parse_constituencies(html_content) do
    case Floki.parse_document(html_content) do
      {:ok, document} ->
        constituencies =
          document
          |> Floki.find("select[name='constituency_id'] option")
          |> Enum.map(fn option ->
            code = option |> Floki.attribute("value") |> List.first()
            name = option |> Floki.text() |> String.trim()
            {code, name}
          end)
          |> Enum.reject(fn {code, _name} -> is_nil(code) or code == "" end)
          |> Enum.map(fn {code, name} ->
            %{
              iebc_code: String.to_integer(code),
              name:
                name
                |> String.downcase()
                |> String.split(" ")
                |> Enum.map(&String.capitalize/1)
                |> Enum.join(" ")
            }
          end)

        {:ok, constituencies}

      {:error, reason} ->
        {:error, "Failed to parse HTML: #{inspect(reason)}"}
    end
  end
end
