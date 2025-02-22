import 'package:flutter/material.dart';

class ListaMatricula extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:vistalista(),
    );
  }
}

class vistalista extends StatefulWidget{
  @override
  _vistalista createState()=> _vistalista();
}

class _vistalista extends State<vistalista>{
  

  // Controlador de busqueda
  TextEditingController buscadorcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar "),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            //Crea el espacio para realizar la busqueda
            child: TextField(
              controller: buscadorcontroller,
              decoration: InputDecoration(
                hintText: "Buscar...",
                border: OutlineInputBorder(),
              ),
              
            ),
          
          ),
          Expanded(
            child: 
            ListView.builder(
              itemBuilder: (context,index) {


                },
            ),
          ),
        ],
      ),
    );
  }

}