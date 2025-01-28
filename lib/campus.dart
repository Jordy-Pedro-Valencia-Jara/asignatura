class Campus {
  int ?id;
  String? nombre;
  

  Campus({this.id,this.nombre});
  Map<String,dynamic> toMap(){
    return {'id':id,'nombre':nombre};
  }
}