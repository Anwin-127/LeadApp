import 'package:hive/hive.dart';
import 'package:netflix/Hive/person.dart';




class AppHive {
  static const String boxPerson = 'person';
  Box box=Hive.box<Person>(boxPerson);

  addPerson(String name, String task)  {
    Person addPerson =  Person(
      name: name,
      task: task,
      // isChecked: "false"

    );
     box.add(addPerson) ;
  }

  updatePerson(String name, String task, int index)  {
    Person updatePerson =  Person(
      name: name,
      task: task,
      // isChecked: "false"

    );
   box.putAt(index, updatePerson);
  }



}