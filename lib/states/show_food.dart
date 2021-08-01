import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:puntproj/models/food_model.dart';
import 'package:puntproj/states/detail_food.dart';
import 'package:puntproj/utility/my_constant.dart';
import 'package:puntproj/utility/my_dialog.dart';
import 'package:puntproj/widgets/show_progress.dart';
import 'package:puntproj/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowFood extends StatefulWidget {
  const ShowFood({Key? key}) : super(key: key);

  @override
  _ShowFoodState createState() => _ShowFoodState();
}

class _ShowFoodState extends State<ShowFood> {
  List<FoodModel> foodModels = [];
  List<FoodModel> searchFoodModels = [];
  final deboncer = Debouncer(milliscond: 500);

  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<Null> readAllData() async {
    String api = '${MyConstant.domain}/punt/getAllData.php';
    await Dio().get(api).then((value) {
      for (var item in json.decode(value.data)) {
        FoodModel model = FoodModel.fromMap(item);
        setState(() {
          foodModels.add(model);
          searchFoodModels = foodModels;
        });
      }
    });
  }

  Future<Null> processLogOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear().then(
          (value) => Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeAuthen, (route) => false),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Food'),
        actions: [
          IconButton(
              onPressed: () => processLogOut(), icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: foodModels.length == 0
          ? ShowProgress()
          : LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: Column(
                  children: [
                    buildSearch(),
                    buildListView(constraints),
                  ],
                ),
              ),
            ),
    );
  }

  Container buildSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        onChanged: (value) {
          deboncer.run(() {
            setState(() {
              searchFoodModels = foodModels
                  .where((element) => element.nameFood
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            });
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: searchFoodModels.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          print('You click => ${searchFoodModels[index].nameFood}');
          // MyDialog().showFoodDialog(context, searchFoodModels[index]);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailFood(foodModel: searchFoodModels[index]),
              ));
        },
        child: Card(
          child: Row(
            children: [
              Container(
                width: constraints.maxWidth * 0.5 - 4,
                height: constraints.maxWidth * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                      '${MyConstant.domain}${searchFoodModels[index].image}'),
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.5 - 4,
                height: constraints.maxWidth * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShowTitle(
                          title: searchFoodModels[index].nameFood,
                          textStyle: MyConstant().h2StyleDark()),
                      ShowTitle(
                          title: searchFoodModels[index].price,
                          textStyle: MyConstant().h2StyleDark()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliscond;
  Timer? timer;
  VoidCallback? callback;

  Debouncer({required this.milliscond});

  run(VoidCallback callback) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(Duration(microseconds: milliscond), callback);
  }
}
