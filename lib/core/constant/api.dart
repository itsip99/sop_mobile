class APIConstants {
  static const String baseUrl = 'wsip.yamaha-jatim.co.id:2448';

  static const String loginEndpoint = '/api/LoginSubDealer/Login';
  static const String fetchBriefDataEndpoint =
      '/api/BrowseSubDealer/SubDealerData';
  static const String createBriefDataEndpoint = '/api/ModifySubDealer';
  static const String fetchSalesProfileEndpoint =
      '/api/BrowseSubDealer/SubDealerSalesman';
  static const String addSalesProfileEndpoint = '/api/ModifySubDealer';

  static const String registerEndpoint = '/auth/register'; // change later
  static const String userProfileEndpoint = '/user/profile'; // change later
  static const String updateProfileEndpoint = '/user/update'; // change later
}
