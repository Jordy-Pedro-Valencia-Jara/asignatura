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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          
        }
        ),
    );
  }
}