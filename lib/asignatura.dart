class Asignatura {
  int ? id;
  String ? nombre;
  int ?duracion;
  int ?campusId;
  
  Asignatura({this.id,this.nombre,this.duracion,this.campusId});
   Map <String,dynamic> toMap(){
    return {
      'id':id,
      'nombre':nombre,
      'duracion':duracion,
      'campusId':campusId,
      };
   }
}