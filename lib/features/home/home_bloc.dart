import 'dart:async';
import 'dart:math';

import 'package:create_wallet/features/home/web_view_screen.dart';
import 'package:create_wallet/model/api_response_message.dart';
import 'package:create_wallet/services/balance_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

enum HomeState { Loading, Success, Failed }

class HomeBloc {
  //region Common variable
  late BuildContext context;
  String balance = "0";
  int balanceAddress = 0;
  int numberOfCheck = 0;
  int numberOfFailedCheck = 0;

  //endregion

//region Text Editing Controller
//endregion

//region Controller
  final seedWordsCtrl = StreamController<String>.broadcast();
  final privateKeyCtrl = StreamController<String>.broadcast();
  final publicAddressCtrl = StreamController<String>.broadcast();
  final balanceCtrl = StreamController<HomeState>.broadcast();

//endregion
  //region Constructor
  HomeBloc(this.context);

  //endregion
//region Init
  void init() {
    getSeedWords();
  }

//endregion


  // Generate a strength value that is a multiple of 32 within a desired range
  int generateStrength() {
    final rng = Random();
    int strength = rng.nextInt(13) + 12; // Generates a number between 12 and 24
    // Ensure the strength is a multiple of 32
    return (strength ~/ 32) * 32;
  }

//region Get seed words
  void getSeedWords() {

    //If balance is not 0
    if (balance != "0") {
      //print(balance);
      return;
    }

    String words = bip39.generateMnemonic(strength: 256);
    //print("Seed phase are : ${words}");
    seedWordsCtrl.sink.add(words);
    //Get private key
    getPrivateKey(words);
  }

  //endregion




//region Get private key
  void getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    // await setPrivateKey(privateKey);
    privateKeyCtrl.sink.add(privateKey);
    getPublicKey(privateKey);
  }

//endregion

//region Get public address
  void getPublicKey(String privateKey) async {
    EthPrivateKey privatKey = EthPrivateKey.fromHex(privateKey);
    final address = await privatKey.address;
    publicAddressCtrl.sink.add(address.hex);
    //Get balance
    getBalance(address: address.hex);
  }

//endregion

//region Go to web view
  void goToWebView({required String ethAddress}) async {
    var screen = WebViewScreen(
      url: "https://etherscan.io/address/$ethAddress",
    );
    var route = MaterialPageRoute(builder: (context) => screen);
    Navigator.push(context, route);
  }

//endregion

//region Get balance
  void getBalance({required String address}) async {
    try {
      //print("Address is : $address");
      //Loading
      balanceCtrl.sink.add(HomeState.Loading);
      //Api call
      balance = await BalanceCheckService().getBalance(address: address);
      //If Balance is more then 0
      if(balance != "0"){
        balanceAddress = balanceAddress + 1;
      }
      //Increase number of checks
      numberOfCheck = numberOfCheck + 1;
      //Success
      balanceCtrl.sink.add(HomeState.Success);
      //Get seed words
      getSeedWords();
    } on ApiErrorResponseMessage catch (error) {
      //Failed
      balanceCtrl.sink.add(HomeState.Failed);
      //Check failed count
      numberOfFailedCheck = numberOfFailedCheck +1;
      getSeedWords();

    } catch (error) {
      //Failed
      balanceCtrl.sink.add(HomeState.Failed);
      //Check failed count
      numberOfFailedCheck = numberOfFailedCheck +1;
      getSeedWords();

    }
  }

//endregion
}
