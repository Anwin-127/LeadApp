import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:netflix/Hive/person.dart';

import 'Widgets/AlignText.dart';
import 'Widgets/TextField.dart';
import 'Hive.dart';
import 'ListPage.dart';
import 'Widgets/SizedBox.dart';
import 'Widgets/TextField.dart';

class EditPage extends StatefulWidget {
  final String name;
  final String task;
  final int i;
  const EditPage(
      {Key? key,
      required this.name,
      required this.task,
      required this.i})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  initState() {
    super.initState();
    nameController.text = widget.name;
    phoneController.text = widget.task;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            if (nameController.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: 'Note cant be empty!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white);
            } else {
              AppHive().updatePerson(nameController.text, phoneController.text,widget.i);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ProfilePage(),
                  transitionDuration: const Duration(milliseconds: 200),
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
                    text: "Lead",
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
                  controller: phoneController,
                  hintText: "Task",
                  label: "Tasks",
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