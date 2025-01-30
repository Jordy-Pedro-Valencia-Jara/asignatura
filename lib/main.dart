import 'package:asignatura/EditarAlumno.dart';
import 'package:asignatura/EditarAsignatura.dart';
import 'package:asignatura/ListaAlumno.dart';
import 'package:flutter/material.dart';
import 'package:asignatura/Inicio.dart';
import 'package:asignatura/ListaAsignatura.dart';
import 'package:asignatura/ListaCampus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "matriculas",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      );
  }
}
class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/":(context) =>Inicio(),
        '/ListaAlumno': (context) => ListaAlumno(),
        '/ListaAsignatura': (context) => ListaAsignatura(),
        '/ListaCampus': (context) => ListaCampus(),
        '/EditarAlumno': (context)=> EditarAlumno(),
        '/EditarAsignatura':(context)=> EditarAsignatura(),
        //'/EditarCampus':(context)=> EditarCampus(),

      },
    );
  }
}
