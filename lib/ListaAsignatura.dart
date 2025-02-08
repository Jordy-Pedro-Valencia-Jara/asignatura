import 'dart:core';
import 'package:asignatura/asignatura.dart';
import 'package:flutter/material.dart';

import 'package:asignatura/db.dart';

class ListaAsignatura extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Asignaturas"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed
          (context, "/EditarAsignatura",
          arguments: Asignatura(id:null,nombre: "",duracion:null,campusId: null));
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
  List<Asignatura> asignatura = [];
  @override
  void initState() {
    mostrarAsignaturas();
    super.initState();
  }

  mostrarAsignaturas()async{
    List<Asignatura> auxAsignatura = await DB.listaAsignaturas();
    setState(() {
      asignatura=auxAsignatura;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: asignatura.length,
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
      onDismissed: (direction) => DB.deleteAsignatura(asignatura[i]),
      child: ListTile(
        title: Text(asignatura[i].nombre??"vacio"),
        trailing: MaterialButton(
          onPressed:(){
            Navigator.pushNamed(context, "/EditarAsignatura",arguments:asignatura[i]);
            print("presionaste editar y se mando ${asignatura[i].nombre}");
          },
          child: Icon(Icons.edit),
        ),
      ),
      ),
    );
  }
}