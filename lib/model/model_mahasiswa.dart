class ModelMahasiswa {
  int? _id;
  String? _nama, _nobp, _nohp, _email, _alamat;
  ModelMahasiswa(this._nama, this._nobp, this._nohp,
      this._email, this._alamat);
  int get id => _id ?? 0;
  String get nama => _nama ?? "";
  String get nobp => _nobp ?? "";
  String get nohp => _nohp ?? "";
  String get email => _email ?? "";
  String get alamat => _alamat ?? "";
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map["id"] = _id;
    }
    map["nama"] = _nama;
    map["nobp"] = _nobp;
    map["nohp"] = _nohp;
    map["email"] = _email;
    map["alamat"] = _alamat;
    return map;
  }

  ModelMahasiswa.froMap(Map<String, dynamic> map) {
    _id = map["id"];
    _nama = map["nama"];
    _nobp= map["nobp"];
    _nohp = map["nohp"];
    _email = map["email"];
    _alamat = map["alamat"];
  }
}
