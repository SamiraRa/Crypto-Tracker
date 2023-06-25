class ApiCall {
  static cryptoApi(params) =>
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?$params";
}
