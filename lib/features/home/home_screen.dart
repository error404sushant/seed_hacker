import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'home_bloc.dart';

//region Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//endregion

class _HomeScreenState extends State<HomeScreen> {
  //region Build
  late HomeBloc homeBloc;

  //endregion
  //region Init
  @override
  void initState() {
    homeBloc = HomeBloc(context);
    homeBloc.init();
    super.initState();
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SeedHacker Pro',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: body(),
        ),
      ),
    );
  }

  //region Body
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          seedWords(),
          const SizedBox(height: 16),
          publicKey(),
          const SizedBox(height: 16),
          balance(),
        ],
      ),
    );
  }

  //endregion

  //region Generate Button
  Widget generateButton() {
    return Center(
      child: CupertinoButton(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(8),
        child: const Text("Generate", style: TextStyle(color: Colors.white)),
        onPressed: () {
          homeBloc.getSeedWords();
        },
      ),
    );
  }

  //endregion

  //region Seed Words
  Widget seedWords() {
    return StreamBuilder<String>(
      stream: homeBloc.seedWordsCtrl.stream,
      initialData: "",
      builder: (context, snapshot) {
        List<String> wordList = snapshot.data!.split(" ");

        // If empty
        if (snapshot.data!.isEmpty) {
          return _buildSection("No words");
        }

        return _buildSection(
          "Number of checks: ${homeBloc.numberOfCheck} Number of failed checks ${homeBloc.numberOfFailedCheck}",
          children: [
            ListView.builder(
              itemCount: wordList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "${index + 1}. ${wordList[index]}",
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  //endregion

  //region Public Key
  Widget publicKey() {
    return StreamBuilder<String>(
      stream: homeBloc.publicAddressCtrl.stream,
      initialData: "",
      builder: (context, snapshot) {
        // If empty
        if (snapshot.data!.isEmpty) {
          return _buildSection("No address");
        }
        return _buildSection(
          "Ethereum address: ${snapshot.data!}",
        );
      },
    );
  }

  //endregion

  //region Balance
  Widget balance() {
    return StreamBuilder<HomeState>(
      stream: homeBloc.balanceCtrl.stream,
      initialData: HomeState.Loading,
      builder: (context, snapshot) {
        if (snapshot.data! == HomeState.Loading) {
          return _buildSection(
            "Fetching balance...",
            children: [
              Row(
                children: [
                  Text("Balance: ${homeBloc.balance}", style: const TextStyle(fontSize: 18, color: Colors.green)),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(height: 25, width: 25, child: const CircularProgressIndicator()),
                ],
              ),
            ],
          );
        }
        // Success
        if (snapshot.data! == HomeState.Success) {
          return _buildSection(
            "Balance: ${homeBloc.balance}",
            textStyle: const TextStyle(fontSize: 18, color: Colors.green),
          );
        }
        // Failed
        return _buildSection("Failed to fetch balance", textStyle: const TextStyle(fontSize: 18, color: Colors.red));
      },
    );
  }

  //endregion

  //region Utility Method
  Widget _buildSection(String title, {List<Widget>? children, TextStyle? textStyle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (children != null) ...children,
      ],
    );
  }
//endregion
}
