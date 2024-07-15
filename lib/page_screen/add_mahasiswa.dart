import 'package:flutter/material.dart';
import 'package:sqllite_project/helper/database_helper.dart';
import
'package:sqllite_project/page_screen/list_mahasiswa.dart';
import
'package:sqllite_project/model/model_mahasiswa.dart';

class AddMahasiswa extends StatefulWidget {
  final ModelMahasiswa? data;

  const AddMahasiswa({super.key, this.data});

  @override
  State<AddMahasiswa> createState() => _AddMahasiswaState();
}

class _AddMahasiswaState extends State<AddMahasiswa> {
  DatabaseHelper db = DatabaseHelper();
  TextEditingController nama = TextEditingController();
  TextEditingController nobp = TextEditingController();
  TextEditingController nohp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alamat = TextEditingController();

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    nama = TextEditingController(text: widget.data?.nama);
    nobp = TextEditingController(text: widget.data?.nobp);
    nohp = TextEditingController(text: widget.data?.nohp);
    email = TextEditingController(text: widget.data?.email);
    alamat = TextEditingController(text: widget.data?.alamat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data?.id != null ? "Update Mahasiswa" :
        "Add Mahasiswa"),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white,
            fontSize: 14),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            TextFormField(
            controller: nama,
            decoration: const InputDecoration(hintText:
            "Nama"),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: nobp,
            decoration: const InputDecoration(hintText:
            "NoBp"),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: nohp,
            decoration: const InputDecoration(hintText: "NoHp"),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(hintText:
              "Email"),
            ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: alamat,
                decoration: const InputDecoration(hintText: "Alamat"),
              ),
            const SizedBox(
              height: 25,
            ),
            MaterialButton(
              minWidth: 200,
              color: Colors.blue,
              height: 45,
              onPressed: () {
                if (widget.data?.id != null) {
                  db
                      .updateMahasiswa(ModelMahasiswa.froMap({
                    "id": widget.data?.id,
                    'nama': nama.text,
                    'nobp': nobp.text,
                    'nohp': nohp.text,
                    'email': email.text,
                    'alamat': alamat.text
                  }))
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ListMahasiswa()),
                            (route) => false);
                  });
                } else {
                  db
                      .saveMahasiswa(ModelMahasiswa(nama.text,
                      nobp.text, nohp.text, email.text, alamat.text)).then((_) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ListMahasiswa()),
                            (route) => false);
                  });
                }
              },
              child: Text(widget.data?.id != null ? "EDIT" :
              "SIMPAN"),
            )
            ],
          ),
        ),
      ),
    );
  }
}



