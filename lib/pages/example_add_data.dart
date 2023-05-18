import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) =>
      Person(name: name ?? this.name, age: age ?? this.age, uuid: uuid);

  String get displayName => '$name ($age years old)';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() => 'Person(name: $name, age: $age, uuid: $uuid)';
}

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];

  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void add(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void update(Person updatePerson) {
    final index = _people.indexOf(updatePerson);
    final oldPerson = _people[index];
    if (oldPerson.name != updatePerson.name ||
        oldPerson.age != updatePerson.age) {
      _people[index] = oldPerson.updated(updatePerson.name, updatePerson.age);
      notifyListeners();
    }
  }
}

final peopleProvider = ChangeNotifierProvider(
  (_) => DataModel(),
);

class ExampleAddData extends ConsumerWidget {
  const ExampleAddData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Add Data'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: (context, index) {
              final person = dataModel.people[index];
              return ListTile(
                title: GestureDetector(
                  onTap: () async {
                    final updatedPerson = await createOrUpdatePersonDialog(
                      context,
                      person,
                    );
                    if (updatedPerson != null) {
                      dataModel.update(updatedPerson);
                    }
                  },
                  child: Text(person.displayName),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = await createOrUpdatePersonDialog(context);
          if (person != null) {
            final dataModel = ref.read(peopleProvider);
            dataModel.add(person);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog<Person?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('创建一个人'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '输入姓名...'),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: '输入年龄...'),
              onChanged: (value) => age = int.tryParse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消')),
          TextButton(
              // onPressed: () => Navigator.of(context).pop(
              //       Person(name: name!, age: age!),
              //     ),
              onPressed: () {
                if (name != null && age != null) {
                  if (existingPerson != null) {
                    final newPerson = existingPerson.updated(
                      name,
                      age,
                    );
                    Navigator.of(context).pop(newPerson);
                  } else {
                    final newPerson = Person(name: name!, age: age!);
                    Navigator.of(context).pop(newPerson);
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('确定')),
        ],
      );
    },
  );
}
