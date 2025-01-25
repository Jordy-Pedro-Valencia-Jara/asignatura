class Campus {
  int ?id;
  String? nombre;
  DateTime? fundacion;

  Campus({this.id,this.nombre,this.fundacion});
  Map<String,dynamic> toMap(){
    return {'id':id,'nombre':nombre,'fundacion':fundacion};
  }
}