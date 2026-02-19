defmodule PatakituoBackend.IebcScrapper do
  @moduledoc """
  Module for scrapping IEBC data and populate the database.
  """

  @base_url Application.compile_env(:patakituo_backend, :iebc_base_url)

  def fetch_constituencies(county_code) do
    url = "#{@base_url}/show_const.php"

    case Req.post(url, form: [cid: county_code]) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status}} ->
        {:error,
         "Failed to fetch constituencies for county code #{county_code}, status: #{status}"}

      {:error, reason} ->
        {:error, "Error fetching constituencies for county code #{county_code}: #{reason}"}
    end
  end

  def fetch_wards(constituency_code) do
    url = "#{@base_url}/show_wards.php"

    case Req.post(url, form: [cid: constituency_code]) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status}} ->
        {:error,
         "Failed to fetch wards for constituency code #{constituency_code}, status: #{status}"}

      {:error, reason} ->
        {:error, "Error fetching wards for constituency code #{constituency_code}: #{reason}"}
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
