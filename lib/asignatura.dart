class Asignatura {
  int ? id;
  String ? nombre;
  int ?duracion;
  
  Asignatura({this.id,this.nombre,this.duracion});
   Map <String,dynamic> toMap(){
    return {'id':id,'nombre':nombre,'duracion':duracion};
   }
}