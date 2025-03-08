import 'package:asignatura/asignatura.dart';
import 'package:asignatura/campus.dart';
import 'package:flutter/material.dart';
import 'package:asignatura/db.dart';

class Matricular extends StatefulWidget{
  @override
  _Matricular createState()=> _Matricular();
}
class _Matricular extends State<Matricular>{
  final _formKey =GlobalKey<FormState>();
  final AsignaturaController =TextEditingController();

  List<Asignatura> asignaturas=[];
  Asignatura ? _selectdAsignatura;
  bool _isInitialized = false;

  @override
  void initState(){
    super.initState();
    _cargarAsignaturas();
  }
  Future <void> _cargarAsignaturas() async{
    List<Asignatura> listadeasignaturas=await DB.listaAsignaturas();
    setState(() {
      asignaturas=listadeasignaturas;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matricular"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<Asignatura>(
                value: _selectdAsignatura, 
                onChanged: (Asignatura? newvalue) {
                  setState(() {
                    _selectdAsignatura=newvalue;
                    AsignaturaController.text=newvalue?.id.toString()??"";
                  });
                },
                items: asignaturas.map<DropdownMenuItem<Asignatura>>((Asignatura asignatura){
                  return DropdownMenuItem<Asignatura>(
                    value: asignatura,
                    child: Text(asignatura.nombre??"vacio"),
                    );
                }).toList(),
                
              ),
            ],
          )
        ),
      ),
    );
  }

}