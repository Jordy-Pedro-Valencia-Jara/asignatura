import 'package:asignatura/alumnoasignatura.dart';
import 'package:asignatura/asignatura.dart';
import 'package:flutter/material.dart';
import 'package:asignatura/alumno.dart';
import 'package:asignatura/matricular.dart';
import 'package:asignatura/db.dart';

class Perfil extends StatelessWidget {
  final Alumno alumno;

  Perfil(this.alumno);

  @override
  Widget build(BuildContext context) {
    return Pprincipal(alumno); // Pasamos el objeto Alumno a Pprincipal
  }
}

class Pprincipal extends StatefulWidget {
  final Alumno alumno;
  Pprincipal(this.alumno);
  

  

  @override
  _PprincipalState createState() => _PprincipalState();
}

class _PprincipalState extends State<Pprincipal> {
  List<Asignatura> matriculados=[];
  @override
  void initState() {
    inscrito();
    super.initState();
  }
    inscrito() async {
    List<AlumnoAsignatura> auxmatricula = await DB.listaAlumnoAsignatura();
    List<Asignatura> asignaturas = await DB.listaAsignaturas();

    // Filtramos solo las inscripciones del alumno actual
    List<int> asignaturasIds = auxmatricula
        .where((a) => a.id_alumno == widget.alumno.id)
        .map((a) => a.id_asignatura)
        .toList();

    setState(() {
      // Filtramos las asignaturas que coincidan con los IDs obtenidos
      matriculados = asignaturas.where((a) => asignaturasIds.contains(a.id)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alumno: ${widget.alumno.nombre ?? 'Sin Nombre'}"),
      ),
      floatingActionButton: 
      FloatingActionButton(
        child: Icon(Icons.add),        
        onPressed: ()=>{
          Navigator.pushNamed(context, "/Matricular"),
          print(widget.alumno.id)
          },
      ),
      body: ListView.builder(
        itemCount: matriculados.length,
        itemBuilder: (context,i)=>
        ListTile(
          title: 
          Text(matriculados[i].nombre?? "vacio"),
        ),
      )
    );
  }
  
}