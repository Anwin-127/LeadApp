import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netflix/Widgets/SizedBox.dart';

import 'Widgets/AlignText.dart';
import 'Widgets/TextField.dart';
import 'Hive.dart';
import 'ListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            if (dataController.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: 'Note cant be empty!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white);
            } else {
              AppHive().addPerson(nameController.text, dataController.text);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ProfilePage(),
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                ),
              );
            }
          },
          child: const Icon(
            Icons.done,
            color: Colors.white,
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: _height,
          child: Column(
            children: [
              addVerticalSpace(50),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                        onPressed: () {

                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const ProfilePage(),
                              transitionDuration: const Duration(milliseconds: 200),
                              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.menu_rounded,
                          size: 30,
                        )),
                  ),
                  AlignText(
                    text: "New Task",
                    size: 30,
                    color: Colors.black,
                    bold: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
              addVerticalSpace(20),
              CustomTextfield(
                  controller: nameController,
                  hintText: "Name",
                  label: "Name",
                  labelSize: 28,
                  maxLength: 35,
                  containerHeight: 100,
                  containerWidth: _width / 1.2,
                  maxLines: 2,
                  fontsize: 35),
              addVerticalSpace(20),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: CustomTextfield(
                  controller: dataController,
                  hintText: "Tasks \n  ",
                  containerWidth: _width / 1.2,
                  containerHeight: 500,
                  maxLines: 100,
                  fontsize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
