import 'package:asignatura/alumno.dart';
import 'package:asignatura/asignatura.dart';
import 'package:asignatura/campus.dart';
import 'package:asignatura/alumnoasignatura.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{
  static String createTableAlumno='''
  CREATE TABLE alumno (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL)'''; 

  static String createTableAsignatura='''
  CREATE TABLE asignatura (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    duracion INTEGER,
    campusId INTEGER,
    FOREIGN KEY (campusId) REFERENCES campus(id))''';

  static String createTableCampus='''
  CREATE TABLE  campus(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL
  )''';

  static String createTableAlumnoAsignatura='''
  CREATE TABLE alumnoasignatura(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_alumno INTEGER NOT NULL,
    id_asignatura INTEGER NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES alumno(id),
    FOREIGN KEY (ID_asignatura) REFERENCES asignatura(id)
  )''';

  static Future <Database> _openDB() async{
    return openDatabase(join(await getDatabasesPath(),'registro.db'),
    onCreate: (db, version) async{
      try{
        await db.execute(createTableAlumno);
        await db.execute(createTableAsignatura);
        await db.execute(createTableCampus);
        await db.execute(createTableAlumnoAsignatura);
      }catch(e){
            print("Error al crear tablas: $e");
      }
    },version :1);
  }
// CRUD alumno
//insertar
  static Future <void> insertAlumno(Alumno alumno)async{
    Database database = await _openDB();
    await database.insert("alumno", alumno.toMap());
  }
  //eliminar
  static Future <void> deleteAlumno(Alumno alumno)async{
    Database database= await _openDB();
    await database.delete(
      "alumno",where: "id = ?",whereArgs: [alumno.id]);
  }
  //editar
  static Future <void> updateAlumno(Alumno alumno)async{
    Database database= await _openDB();
    await database.update(
      "alumno", alumno.toMap(),where: "id = ?",whereArgs: [alumno.id]);
  }

  //Lista de alumnos
    static Future<List<Alumno>> ListaAlumnos() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> alumnosMap = await database.query("alumno");

    return List.generate(alumnosMap.length,
            (i) => Alumno(
              id: alumnosMap[i]['id'],
              nombre: alumnosMap[i]['nombre'],
              apellido: alumnosMap[i]['especie']
            )
          );
  }

  //CRUD asignatura
  //insertar
  static Future<void> insertAsigantura(Asignatura asignatura)async{
    Database database=await _openDB();
    await database.insert("asignatura", asignatura.toMap());
  }
  //eliminar
  static Future<void> deleteAsignatura(Asignatura asignatura)async{
    Database database =await _openDB();
    await database.delete(
      "asignatura",where: "id = ?",whereArgs: [asignatura.id]);
  }
  //editar
  static Future<void>updateAsignatura(Asignatura asignatura)async{
    Database database= await _openDB();
    await database.update(
      "asignatura", asignatura.toMap(),where: "id =?",whereArgs: [asignatura.id]);
  }
  
  //Lista de asiganturas
    static Future<List<Asignatura>> ListaAsignaturas() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> asignaturaMap = await database.query("asignatura");

    return List.generate(asignaturaMap.length,
            (i) => Asignatura(
              id: asignaturaMap[i]['id'],
              nombre: asignaturaMap[i]['nombre'],
              duracion: asignaturaMap[i]['duracion'],
              campusId: asignaturaMap[i]['campusId']
            )
          );
  }
  //CRUD campus
  //insertar
  static Future<void> insertCampus(Campus campus)async{
    Database database=await _openDB();
    await database.insert("campus", campus.toMap());
  }
  //eliminar
    static Future<void> deleteCampus(Campus campus)async{
    Database database=await _openDB();
    await database.delete("campus", where: "id = ?", whereArgs: [campus.id]);
  }
  //editar
    static Future<void> updateCampus(Campus campus)async{
    Database database=await _openDB();
    await database.update(
      "campus", campus.toMap(),where: "id = ?",whereArgs: [campus.id]);
  }
  //lista de campus
  static Future<List<Campus>>ListaCampus()async{
    Database database =await _openDB();
    final List<Map<String,dynamic>> campusMap =await database.query("campus");
    return List.generate(campusMap.length,
    (i)=>Campus(
      id: campusMap[i]['id'],
      nombre: campusMap[i]['nombre']
    ));
  }
  //CRUD alumnoasignatura
  //insertar 
  static Future <void> insertAlumnoAsignatura(AlumnoAsignatura alumnoasignatura)async{
    Database database= await _openDB();
    await database.insert(
      "alumnoasignatura", alumnoasignatura.toMap());
  }

  //eliminar
  static Future <void> deleteAlumnoAsignatura(AlumnoAsignatura alumnoasignatura)async{
    Database database= await _openDB();
    await database.delete(
      "alumnoasignatura",
      where: "id = ?",
      whereArgs: [alumnoasignatura.id]);
  }

  //Actualizar
  static Future<void> updateAlumnoAsignatura(AlumnoAsignatura alumnoasignatura)async{
    Database database= await _openDB();
    await database.update(
      "alumnoasignatura", 
      alumnoasignatura.toMap(),
      where: "id=?",
      whereArgs: [alumnoasignatura.id]);
  }

  //Listar AlumnoAsignatura

  static Future<List<AlumnoAsignatura>>ListaAlumnoAsignatura() async{
    Database database =await _openDB();
    final List<Map<String,dynamic>> AlumnoAsignaturaMap =await database.query("alumnoasignatura");
    return List.generate(AlumnoAsignaturaMap.length,
    (i)=>AlumnoAsignatura(
      id: AlumnoAsignaturaMap[i]['id'],
      id_alumno: AlumnoAsignaturaMap[i]['id_alumno'],
      id_asignatura: AlumnoAsignaturaMap[i]['id_asignatura']

    ));
  }

}