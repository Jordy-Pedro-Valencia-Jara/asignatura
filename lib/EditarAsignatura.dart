import 'dart:core';

import 'package:asignatura/asignatura.dart';
import 'package:flutter/material.dart';

import 'package:asignatura/db.dart';


class EditarAsignatura extends StatefulWidget{
  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<EditarAsignatura>{
  final _formKey =GlobalKey<FormState>();
  final nombreController= TextEditingController();
  final duracionController= TextEditingController();
  final campusidController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if(args==null || args is! Asignatura){
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Argumento vacio"),
        ),
      );
    }

    //Inicializar objeto asigatura
    Asignatura asignatura= args;

    nombreController.text = asignatura.nombre ??  "";
    duracionController.text=asignatura.duracion?.toString() ?? "";
    campusidController.text = asignatura.campusId?.toString() ?? "";
    String encabezado="";
    if (nombreController.text=="" && duracionController.text=="" && campusidController.text==""){
      encabezado="Crear Asignatura";
    }else{
      encabezado="Editar Asignatura";
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
                controller: duracionController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value== null|| value.isEmpty){
                    return "Debe tener una duracion";
                  }else{
                    return null;
                  } 
                },
                decoration: InputDecoration(labelText: "Duracion"),
              ),
              //sujeto a cambios 
              TextFormField(
                controller: campusidController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value== null|| value.isEmpty){
                    return "Debe tener un campus";
                  }else{
                    return null;
                  } 
                },
                decoration: InputDecoration(labelText: "Campus"),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed:(){
                  if(_formKey.currentState?.validate() ?? false){
                    //(alumno.id ?? 0) > 0
                     if(asignatura.id != null && asignatura.id! > 0){
                      asignatura.nombre = nombreController.text;
                      asignatura.duracion = int.parse(duracionController.text);
                      asignatura.campusId = int.parse(campusidController.text);
                      DB.updateAsignatura(asignatura);
                     }else{
                      DB.insertAsigantura(Asignatura(
                        nombre: nombreController.text,
                        duracion: int.parse(duracionController.text),
                        campusId: int.parse(campusidController.text)
                      ));
                     }
                     Navigator.pushReplacementNamed(context, "/ListaAsignatura");
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
    duracionController.dispose();
    campusidController.dispose();
    super.dispose();
  }
}