import 'package:flutter/material.dart';
import'package:sqllite_project/page_screen/add_mahasiswa.dart';
import 'package:sqllite_project/helper/database_helper.dart';
import'package:sqllite_project/model/model_mahasiswa.dart';

class ListMahasiswa extends StatefulWidget {
  const ListMahasiswa({super.key});

  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  DatabaseHelper db = DatabaseHelper();
  List<ModelMahasiswa> itemList = [];

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    db.getAllMahasiswa().then((value) {
      setState(() {
        for (var item in value!) {
          itemList.add(ModelMahasiswa.froMap(item));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Mahasiswa"),
        backgroundColor: Colors.green,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddMahasiswa()),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          ModelMahasiswa data = itemList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Card(
              child: ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddMahasiswa(data: data),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Anda yakin menghapus data ${data.nama}?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    db.deleteMahasiswa(data.id).then((_) {
                                      setState(() {
                                        itemList.removeAt(index);
                                      });
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                title: Text(data.nama),
                subtitle: Text(data.email),
              ),
            ),
          );
        },

      ),
    );
  }

}


