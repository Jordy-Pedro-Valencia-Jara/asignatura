import 'package:asignatura/alumno.dart';
import 'package:flutter/material.dart';
import 'package:asignatura/db.dart';
import 'package:asignatura/perfil.dart';

class ListaMatricula extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return vistalista();
  }
}

class vistalista extends StatefulWidget{
  @override
  _vistalista createState()=> _vistalista();
}

class _vistalista extends State<vistalista>{
  //Lista de alumnos 
  List<Alumno> alumnos=[];
  //Lista filtrada de alumnos 
  List<Alumno> alumnofiltro=[];
  // Controlador de busqueda
  TextEditingController buscadorcontroller = TextEditingController();

  @override
  void initState(){
    super.initState();
    llenaralumnos();
  }
  llenaralumnos()async{
    alumnos=await DB.listaAlumnos();
    setState(() {
      alumnofiltro=List.from(alumnos);  
    });
    
  }
  void buscar(String query){
    setState(() {
      alumnofiltro=alumnos
      .where((alumno)=>(alumno.nombre??'')
      .toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void onAlumnoClicked(Alumno alumno){
    //ScaffoldMessenger.of(context).showSnackBar(
    //SnackBar(content: Text("Alumno $alumno")),
    //);
    Navigator.pushNamed(context, "/Perfil",arguments: (alumno),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar "),
      ),
      body: Column(
        children: [
          //campo de busqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            //Crea el espacio para realizar la busqueda
            child: TextField(
              controller: buscadorcontroller,
              decoration: InputDecoration(
                hintText: "Buscar...",
                border: OutlineInputBorder(),
              ),
              onChanged: buscar,
            ),
          
          ),
          Expanded(
            child: 
            ListView.builder(
              itemCount: alumnofiltro.length,
              itemBuilder: (context,index) {
                return ListTile(
                  title: Text(alumnofiltro[index].nombre??""),
                  onTap: () {
                    onAlumnoClicked(alumnofiltro[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}