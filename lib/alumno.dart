class Alumno {
  int ? id;
  String ? nombre;
  String ? apellido;
  Alumno ({this.id,this.nombre,this.apellido});

  Map<String,dynamic> toMap(){
    return{'id':id,'nombre':nombre,'apellido':apellido};
  }

}