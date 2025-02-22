import 'package:flutter/material.dart';

class ListaMatricula extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchableListView(),
    );
  }
}

class SearchableListView extends StatefulWidget {
  @override
  _SearchableListViewState createState() => _SearchableListViewState();
}

class _SearchableListViewState extends State<SearchableListView> {
  // Lista de juguetes
  List<String> toys = ["Pelota", "Carrito", "Muñeca", "Lego", "Tren", "Avión"];

  // Lista filtrada (se actualiza cuando buscamos)
  List<String> filteredToys = [];

  // Controlador para el campo de búsqueda
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Al inicio, la lista filtrada es igual a la lista completa
    filteredToys = List.from(toys);
  }

  // Función para filtrar la lista
  void filterToys(String query) {
    setState(() {
      filteredToys = toys
          .where((toy) => toy.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Función para manejar el clic en un juguete
  void onToyClicked(String toy) {
    // Muestra un mensaje (SnackBar) con el juguete seleccionado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Seleccionaste: $toy"),
      ),
    );

    // También puedes navegar a otra pantalla aquí si lo deseas
    // Navigator.push(context, MaterialPageRoute(builder: (context) => OtraPantalla(toy)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Juguetes"),
      ),
      body: Column(
        children: [
          // Campo de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Buscar juguete...",
                border: OutlineInputBorder(),
              ),
              onChanged: filterToys, // Llama a la función cuando escribes
            ),
          ),
          // Lista de juguetes filtrados
          Expanded(
            child: ListView.builder(
              itemCount: filteredToys.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredToys[index]),
                  onTap: () {
                    // Llama a la función cuando se hace clic en un juguete
                    onToyClicked(filteredToys[index]);
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