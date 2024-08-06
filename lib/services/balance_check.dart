//happy
import 'package:create_wallet/services/http_service.dart';


class BalanceCheckService {
  // region Common Variables
  late HttpService httpService;

  // endregion

  // region | Constructor |
  BalanceCheckService() {
    httpService = HttpService();
  }

  // endregion


  // region Get balance
  Future<String>getBalance({required String address}) async {
    Map<String, dynamic> response;
    //#region Region - Execute Request
    response = await httpService.getApiCall("https://api.etherscan.io/api?module=account&action=balance&address=$address&tag=latest&apikey=E421EWATI4K1J5JPR58F92PRA59BB97Q6B");
    return response['result'];
  }
// endregion





}
