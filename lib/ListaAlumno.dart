import 'dart:core';
import 'package:flutter/material.dart';
import 'package:asignatura/alumno.dart';
import 'package:asignatura/db.dart';

class ListaAlumno extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de alumnos"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed
          (context, "/EditarAlumno",
          arguments: Alumno(id:0,nombre: "",apellido: ""));
        }  
      ),
      body: Container(
        child: Lista()
      ),
    );
  }
}
class Lista extends StatefulWidget{
  @override
  _MiLista createState()=> _MiLista();
}
class _MiLista extends State<Lista>{
  List<Alumno> alumno = [];
  @override
  void initState() {
    mostrarAlumnos();
    super.initState();
  }

  mostrarAlumnos()async{
    List<Alumno> auxAlumno = await DB.ListaAlumnos();
    setState(() {
      alumno=auxAlumno;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: alumno.length,
      itemBuilder: 
      (context, i) => 
      Dismissible(key: Key(i.toString()),
      direction: DismissDirection.startToEnd, 
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete,color: Colors.white),
        ),
      ),
      onDismissed: (direction) => DB.deleteAlumno(alumno[i]),
      child: ListTile(
        title: Text(alumno[i].nombre??"vacio"),
        trailing: MaterialButton(
          onPressed:(){
            Navigator.pushNamed(context, "/EditarAlumno",arguments:alumno[i]);
          },
          child: Icon(Icons.edit),
        ),
      ),
      ),
    );
  }
}