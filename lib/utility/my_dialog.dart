import 'package:flutter/material.dart';
import 'package:puntproj/models/food_model.dart';
import 'package:puntproj/utility/my_constant.dart';
import 'package:puntproj/widgets/show_image.dart';
import 'package:puntproj/widgets/show_title.dart';

class MyDialog {
  Future<Null> showFoodDialog(BuildContext context, FoodModel foodModel) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.network('${MyConstant.domain}${foodModel.image}'),
          title: ShowTitle(title: foodModel.nameFood, textStyle: MyConstant().h2StyleDark()),
        ),
      ),
    );
  }

  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(),
          title: ShowTitle(
            title: title,
            textStyle: MyConstant().h2StyleDark(),
          ),
          subtitle: ShowTitle(
            title: message,
            textStyle: MyConstant().h3StyleDark(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }
}
