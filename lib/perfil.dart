import 'package:flutter/material.dart';
import 'package:asignatura/alumno.dart';

class Perfil extends StatelessWidget {
  final Alumno alumno;

  Perfil(this.alumno);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pprincipal(alumno), // Pasamos el objeto Alumno a Pprincipal
    );
  }
}

class Pprincipal extends StatefulWidget {
  final Alumno alumno;

  Pprincipal(this.alumno);

  @override
  _PprincipalState createState() => _PprincipalState();
}

class _PprincipalState extends State<Pprincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alumno: ${widget.alumno.nombre ?? 'Sin Nombre'}"),
      ),
    );
  }
}