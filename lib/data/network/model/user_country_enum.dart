enum AppCountryEnum {
  uz(baseUrl: "https://api.crm1.35minut.club/api/v2/client", formatter: "+998", phonePrefix: '+998 '),
  kz(baseUrl: "https://api.crm2.35minut.club/api/v2/client", formatter: "+998", phonePrefix: '+7 ');

  final String baseUrl;
  final String phonePrefix;
  final String formatter;

  const AppCountryEnum({required this.baseUrl, required this.phonePrefix, required this.formatter});
}
