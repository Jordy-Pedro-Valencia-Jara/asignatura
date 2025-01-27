class AlumnoAsignatura{
  int?id;
  int id_alumno;
  int id_asignatura;

  AlumnoAsignatura({this.id,required this.id_alumno,required this.id_asignatura});

  Map <String,dynamic> toMap(){
    return {'id':id,'id_alumno':id_alumno,'id_asignatura':id_asignatura};
  }
}