import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:netflix/EditPage.dart';
import 'package:netflix/Hive.dart';
import 'package:netflix/HomePage.dart';
import 'package:netflix/Hive/person.dart';

import 'Widgets/AlignText.dart';
import 'HomePage.dart';
import 'Widgets/SizedBox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSelected = true;
  List<Person> listPerson = [];

  void getPersons() async {
    final box = Hive.box<Person>(AppHive.boxPerson);
    setState(() {
      listPerson = box.values.toList();
    });
  }

  List selectedList = [];
  int selected = 0;
  bool isVisible = false;
  bool isTrueCheck = true;

  @override
  void initState() {
    getPersons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                          pageBuilder: (_, __, ___) => const HomePage(),
                          transitionDuration: const Duration(milliseconds: 200),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    )),
              ),
              AlignText(
                text: "Tasks",
                size: 30,
                color: Colors.black,
                bold: FontWeight.w600,
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: listPerson.length,
                itemBuilder: (context, index) {
                  Person getPerson = listPerson[index];

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => EditPage(
                                  name: getPerson.name,
                                  task: getPerson.task,
                                  i: index),
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c),
                            ),
                          );
                        },
                        child: ListTile(
                            tileColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.all(9),

                            ///tile color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    getPerson.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    getPerson.task,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orangeAccent[100],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: PopupMenuButton<int>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.white,
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(
                                    value: 0,
                                    height: 10,
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green[300],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  EditPage(
                                                      name: getPerson.name,
                                                      task: getPerson.task,
                                                      i: index),
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 200),
                                              transitionsBuilder:
                                                  (_, a, __, c) =>
                                                      FadeTransition(
                                                          opacity: a, child: c),
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade400,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (selectedList.contains(index)) {
                                            selectedList.remove(index);
                                          } else {
                                            selectedList.clear();
                                            selectedList.add(index);
                                          }
                                        });

                                        if (selectedList.isNotEmpty) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0)),
                                              elevation: 0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              title: Column(children: [
                                                Container(
                                                  height: 200,
                                                  width: 350,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.grey),
                                                  child: Center(
                                                    child: Text(
                                                        "Are you sure you want to \n delete this?",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 21,
                                                            color: Colors.white,
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    TextButton(
                                                      style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        )),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .grey[400]),
                                                      ),
                                                      onPressed: () {
                                                        final box = Hive.box<
                                                                Person>(
                                                            AppHive.boxPerson);
                                                        for (int k = 0;
                                                            k <
                                                                selectedList
                                                                    .length;
                                                            k++) {
                                                          box.deleteAt(
                                                              selectedList[k]);
                                                          setState(() => {
                                                                listPerson.removeAt(
                                                                    selectedList[
                                                                        k])
                                                              });
                                                        }

                                                        Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (_, __,
                                                                    ___) =>
                                                                const ProfilePage(),
                                                            transitionDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            transitionsBuilder: (_,
                                                                    a, __, c) =>
                                                                FadeTransition(
                                                                    opacity: a,
                                                                    child: c),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        '  OK  ',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 90,
                                                    ),
                                                    TextButton(
                                                      style: ButtonStyle(
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          )),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                          .grey[200])),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (_, __,
                                                                    ___) =>
                                                                const ProfilePage(),
                                                            transitionDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            transitionsBuilder: (_,
                                                                    a, __, c) =>
                                                                FadeTransition(
                                                                    opacity: a,
                                                                    child: c),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        '  Cancel  ',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
