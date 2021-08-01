import 'package:flutter/material.dart';
import 'package:puntproj/models/food_model.dart';
import 'package:puntproj/utility/my_constant.dart';

class DetailFood extends StatefulWidget {
  final FoodModel foodModel;
  const DetailFood({
    Key? key,
    required this.foodModel,
  }) : super(key: key);

  @override
  _DetailFoodState createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  FoodModel? model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.foodModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model!.nameFood),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              buildImage(constraints),
              Container(width: constraints.maxWidth*0.75,
                child: Text(model!.detail),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildImage(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.6,
      child: Image.network('${MyConstant.domain}${model!.image}'),
    );
  }
}
