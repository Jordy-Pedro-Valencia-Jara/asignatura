
import 'dart:core';
import 'package:asignatura/campus.dart';
import 'package:flutter/material.dart';
import 'package:asignatura/db.dart';

class ListaCampus extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Campus"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed
          (context, "/EditarCampus",
          arguments: Campus(id:null,nombre: ""));
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
  List<Campus> campus = [];
  @override
  void initState() {
    mostrarCampus();
    super.initState();
  }

  mostrarCampus()async{
    List<Campus> auxCampus = await DB.listaCampus();
    setState(() {
      campus=auxCampus;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: campus.length,
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
      onDismissed: (direction) => DB.deleteCampus(campus[i]),
      child: ListTile(
        title: Text(campus[i].nombre??"vacio"),
        trailing: MaterialButton(
          onPressed:(){
            Navigator.pushNamed(context, "/EditarCampus",arguments:campus[i]);
          },
          child: Icon(Icons.edit),
        ),
      ),
      ),
    );
  }
}
