import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:puntproj/utility/my_constant.dart';
import 'package:puntproj/utility/my_dialog.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Container buildName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: TextFormField(
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Name';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.face_outlined),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildUser(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: TextFormField(
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill User';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.perm_identity),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Password';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildCreateAccount(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            String name = nameController.text;
            String user = userController.text;
            String password = passwordController.text;
            print('name = $name, user = $user, password = $password');
            processAddUser(name: name, user: user, password: password);
          }
        },
        child: Text('Create Account'),
      ),
    );
  }

  Future<Null> processAddUser(
      {String? name, String? user, String? password}) async {
    String urlAPIcheckUser =
        '${MyConstant.domain}/punt/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(urlAPIcheckUser).then((value) async {
      if (value.toString() == 'null') {
        String urlAPI =
            '${MyConstant.domain}/punt/insertData.php?isAdd=true&name=$name&user=$user&password=$password';
        await Dio().get(urlAPI).then((value) {
          if (value.toString() == 'true') {
            Navigator.pop(context);
          } else {
            print('Error Cannot Create Account');
          }
        });
      } else {
        print('User False');
        MyDialog().normalDialog(context, 'User Fasle', 'Please Change User ?');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    buildName(constraints),
                    SizedBox(
                      height: 16,
                    ),
                    buildUser(constraints),
                    SizedBox(
                      height: 16,
                    ),
                    buildPassword(constraints),
                    SizedBox(
                      height: 16,
                    ),
                    buildCreateAccount(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
