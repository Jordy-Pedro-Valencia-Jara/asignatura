
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:asignatura/campus.dart';
import 'package:asignatura/db.dart';


class EditarCampus extends StatefulWidget{
  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<EditarCampus>{
  final _formKey =GlobalKey<FormState>();
  final nombreController= TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if(args==null || args is! Campus){
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
    Campus campus= args;

    nombreController.text = campus.nombre ??  "";

    String encabezado="";
    if (nombreController.text=="" ){
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

              SizedBox(height: 30,),
              ElevatedButton(
                onPressed:(){
                  if(_formKey.currentState?.validate() ?? false){
                    //(alumno.id ?? 0) > 0
                     if(campus.id != null && campus.id! > 0){
                      campus.nombre = nombreController.text;
                      DB.updateCampus(campus);
                     }else{
                      DB.insertCampus(Campus(
                        nombre: nombreController.text,
                      ));
                     }
                     Navigator.pushReplacementNamed(context, "/ListaCampus");
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
    super.dispose();
  }
}
