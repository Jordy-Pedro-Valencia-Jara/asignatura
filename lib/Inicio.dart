import 'dart:core';
import 'package:asignatura/ListaAlumno.dart';
import 'package:asignatura/ListaAsignatura.dart';
import 'package:asignatura/ListaCampus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Inicio extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matriculas"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context,"/ListaAlumno");
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.amber,
              ),
              child: Text(
                "Lista de Alumnos",
                style: TextStyle(fontSize: 18),
              ),
        ),
      ),
      SizedBox(height: 30,),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context,"/ListaAsignatura");
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.amber,
              ),
              child: Text(
                "Lista de Asignaturas",
                style: TextStyle(fontSize: 18),
              ),
        ),
      ),
      SizedBox(height: 30,),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context,"/ListaCampus");
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.amber,
              ),
              child: Text(
                "Lista de Campus",
                style: TextStyle(fontSize: 18),
              ),
        ),
      ),
          ],
        ),

    )
    );
  }
}