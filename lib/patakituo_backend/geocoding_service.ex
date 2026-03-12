defmodule PatakituoBackend.GeocodingService do
  @moduledoc """
  Geocodes address strings to geographic coordinates using the Nominatim API (OpenStreetMap).
  Results are restricted to Kenya.
  """

  @nominatim Application.compile_env(:patakituo_backend, :nominatim, [])
  @base_url Keyword.get(@nominatim, :url, "https://nominatim.openstreetmap.org")
  @user_agent Keyword.get(@nominatim, :user_agent, "PatakituoBackend/1.0")

  @doc """
  Geocodes a query string and returns a `%Geo.Point{}` on success.

  ## Examples

      iex> GeocodingService.geocode("Majengo Primary School, Westlands, Nairobi")
      {:ok, %Geo.Point{coordinates: {36.8219, -1.2921}, srid: 4326}}

      iex> GeocodingService.geocode("zzznomatchxxx")
      {:error, :not_found}
  """
  def geocode(query) when is_binary(query) do
    url = @base_url <> "/search"

    case Req.get(url,
           params: [q: query, format: "json", limit: 1, countrycodes: "ke"],
           headers: [{"user-agent", @user_agent}, {"accept-language", "en"}]
         ) do
      {:ok, %{status: 200, body: [%{"lat" => lat_str, "lon" => lng_str} | _]}} ->
        lat = String.to_float(lat_str)
        lng = String.to_float(lng_str)
        {:ok, %Geo.Point{coordinates: {lng, lat}, srid: 4326}}

      {:ok, %{status: 200, body: []}} ->
        {:error, :not_found}

      _ ->
        {:error, :api_error}
    end
  end
end
