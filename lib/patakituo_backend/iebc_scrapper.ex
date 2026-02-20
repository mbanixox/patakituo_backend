defmodule PatakituoBackend.IebcScrapper do
  @moduledoc """
  Module for scrapping IEBC data in HTML format
  """

  alias PatakituoBackend.{IebcParser, Constituencies, Wards}

  @base_url Application.compile_env(:patakituo_backend, :iebc_base_url)

  def fetch_constituencies(county_code) do
    url = "#{@base_url}/show_const.php"

    case Req.post(url, form: [cid: county_code]) do
      {:ok, %{status: 200, body: body}} ->
        with {:ok, parsed_data} <- IebcParser.parse_constituencies(body),
             {:ok, constituencies} <-
               Constituencies.bulk_create_constituencies(county_code, parsed_data) do
          {:ok, constituencies}
        end

      {:ok, %{status: status}} ->
        {:error,
         "Failed to fetch constituencies for county code #{county_code}, status: #{status}"}

      {:error, reason} ->
        {:error, "Error fetching constituencies for county code #{county_code}: #{reason}"}
    end
  end

  def fetch_wards(constituency_iebc_code) do
    url = "#{@base_url}/show_wards.php"

    case Req.post(url, form: [ccid: constituency_iebc_code]) do
      {:ok, %{status: 200, body: body}} ->
        with {:ok, parsed_data} <- IebcParser.parse_wards(body),
             {:ok, wards} <-
               Wards.bulk_create_wards(constituency_iebc_code, parsed_data) do
          {:ok, wards}
        end

      {:ok, %{status: status}} ->
        {:error,
         "Failed to fetch wards for constituency iebc code #{constituency_iebc_code}, status: #{status}"}

      {:error, reason} ->
        {:error, "Error fetching wards for constituency iebc code #{constituency_iebc_code}: #{reason}"}
    end
  end

  def fetch_polling_stations(ward_code) do
    url = "#{@base_url}/show_stations.php"

    case Req.post(url, form: [cid: ward_code]) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status}} ->
        {:error, "Failed to fetch polling stations for ward code #{ward_code}, status: #{status}"}

      {:error, reason} ->
        {:error, "Error fetching polling stations for ward code #{ward_code}: #{reason}"}
    end
  end

  def fetch_registration_officers(constituency_code) do
    url = "#{@base_url}/show_contacts.php"

    case Req.post(url, form: [cid: constituency_code]) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status}} ->
        {:error,
         "Failed to fetch registration officers for constituency code #{constituency_code}, status: #{status}"}

      {:error, reason} ->
        {:error,
         "Error fetching registration officers for constituency code #{constituency_code}: #{reason}"}
    end
  end
end
