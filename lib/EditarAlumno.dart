import 'dart:core';

import 'package:flutter/material.dart';
import 'package:asignatura/alumno.dart';
import 'package:asignatura/db.dart';


class EditarAlumno extends StatefulWidget{
  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<EditarAlumno>{
  final _formKey =GlobalKey<FormState>();
  final nombreController= TextEditingController();
  final apellidoController= TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if(args==null || args is! Alumno){
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Argumento vacio"),
        ),
      );
    }

    //Inicializar objeto alumno
    Alumno alumno= args;

    nombreController.text = alumno.nombre ??  "";
    apellidoController.text = alumno.apellido ?? "";
    String encabezado="";
    if (nombreController.text=="" && apellidoController.text==""){
      encabezado="Crear Alumno";
    }else{
      encabezado="Editar Alumno";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(encabezado),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key:_formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nombreController,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Necesita un nombre";
                  }else{
                    return null;
                  } 
                },
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextFormField(
                controller: apellidoController,
                validator: (value) {
                  if(value== null|| value.isEmpty){
                    return "Necesita un apellido";
                  }else{
                    return null;
                  } 
                },
                decoration: InputDecoration(labelText: "Apellido"),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed:(){
                  if(_formKey.currentState?.validate() ?? false){
                    //(alumno.id ?? 0) > 0
                     if(alumno.id != null && alumno.id! > 0){
                      alumno.nombre= nombreController.text;
                      alumno.apellido= apellidoController.text;
                      DB.updateAlumno(alumno);
                     }else{
                      DB.insertAlumno(Alumno(
                        nombre: nombreController.text,
                        apellido: apellidoController.text,
                      ));
                     }
                     Navigator.pushReplacementNamed(context, "/ListaAlumno");
                  }
                },
                child: Text("Guardar"), 
                ),
            ],
          ),
        ),
        )
    );
  }
  
  @override
  void dispose() {
    // Liberar los controladores cuando el widget se destruya
    nombreController.dispose();
    apellidoController.dispose();
    super.dispose();
  }
}