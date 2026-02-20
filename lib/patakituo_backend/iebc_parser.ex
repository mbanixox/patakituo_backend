defmodule PatakituoBackend.IebcParser do
  @moduledoc """
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

  def parse_wards(html_content) do
    case Floki.parse_document(html_content) do
      {:ok, document} ->
        wards =
          document
          |> Floki.find("select[name='ward_id'] option")
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

        {:ok, wards}

      {:error, reason} ->
        {:error, "Failed to parse HTML: #{inspect(reason)}"}
    end
  end

  def parse_polling_stations(html_content) do
    case Floki.parse_document(html_content) do
      {:ok, document} ->
        stations =
          document
          |> Floki.find("table#overallstats tbody tr td")
          |> Enum.map(fn td ->
            name =
              td
              |> Floki.text()
              |> String.trim()
              |> String.downcase()
              |> String.split(" ")
              |> Enum.map(&String.capitalize/1)
              |> Enum.join(" ")

            %{name: name}
          end)
          |> Enum.reject(fn %{name: name} -> name == "" end)

        {:ok, stations}

      {:error, reason} ->
        {:error, "Failed to parse HTML: #{inspect(reason)}"}
    end
  end

  def parse_registration_officers(html_content) do
    case Floki.parse_document(html_content) do
      {:ok, document} ->
        officers =
          document
          |> Floki.find("table tr")
          |> Enum.map(fn tr ->
            tds = Floki.find(tr, "td")

            case tds do
              [name_td, email_td | _] ->
                name =
                  name_td
                  |> Floki.text()
                  |> String.trim()
                  |> String.downcase()
                  |> String.split(" ")
                  |> Enum.map(&String.capitalize/1)
                  |> Enum.join(" ")

                email =
                  email_td
                  |> Floki.text()
                  |> String.trim()
                  |> String.downcase()

                %{name: name, email: email}

              _ ->
                nil
            end
          end)
          |> Enum.reject(&is_nil/1)
          |> Enum.reject(fn %{name: name, email: email} -> name == "" or email == "" end)

        {:ok, officers}

      {:error, reason} ->
        {:error, "Failed to parse HTML: #{inspect(reason)}"}
    end
  end
end
