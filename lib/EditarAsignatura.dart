import 'dart:core';
import 'package:asignatura/asignatura.dart';
import 'package:asignatura/campus.dart';
import 'package:flutter/material.dart';
import 'package:asignatura/db.dart';

class EditarAsignatura extends StatefulWidget {
  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<EditarAsignatura> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final duracionController = TextEditingController();
  final campusidController = TextEditingController();

  List<Campus> campus = []; // Lista de campus
  Campus? _selectedCampus; // Campus seleccionado
  bool _isInitialized = false; // Bandera para evitar reiniciar los controladores

  @override
  void initState() {
    super.initState();
    _cargarCampus(); // Cargar la lista de campus al inicializar el widget
  }

  // Método para cargar la lista de campus
  Future<void> _cargarCampus() async {
    List<Campus> listaCampus = await DB.listaCampus();
    setState(() {
      campus = listaCampus; // Actualizar el estado con la lista de campus
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Asignatura) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Argumento vacío"),
        ),
      );
    }

    // Inicializar objeto asignatura
    Asignatura asignatura = args;

    // Inicializar los controladores solo una vez
    if (!_isInitialized) {
      nombreController.text = asignatura.nombre ?? "";
      duracionController.text = asignatura.duracion?.toString() ?? "";
      campusidController.text = asignatura.campusId?.toString() ?? "";
      _isInitialized = true; // Marcar como inicializado
    }

    String encabezado = (nombreController.text.isEmpty &&
            duracionController.text.isEmpty &&
            campusidController.text.isEmpty)
        ? "Crear Asignatura"
        : "Editar Asignatura";

    return Scaffold(
      appBar: AppBar(
        title: Text(encabezado),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nombreController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Necesita un nombre";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextFormField(
                controller: duracionController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Debe tener una duración";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(labelText: "Duración"),
              ),
              // Dropdown para seleccionar el campus
              DropdownButtonFormField<Campus>(
                value: _selectedCampus, // Valor seleccionado
                onChanged: (Campus? newValue) {
                  setState(() {
                    _selectedCampus = newValue; // Actualizar el campus seleccionado
                    campusidController.text = newValue?.id.toString() ?? ""; // Actualizar el controlador
                  });
                },
                items: campus.map<DropdownMenuItem<Campus>>((Campus campus) {
                  return DropdownMenuItem<Campus>(
                    value: campus,
                    child: Text(campus.nombre ?? "Sin nombre"), // Mostrar el nombre del campus
                  );
                }).toList(),
                decoration: InputDecoration(labelText: "Campus"),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (asignatura.id != null && asignatura.id! > 0) {
                      asignatura.nombre = nombreController.text;
                      asignatura.duracion = int.parse(duracionController.text);
                      asignatura.campusId = int.parse(campusidController.text);
                      DB.updateAsignatura(asignatura);
                    } else {
                      DB.insertAsigantura(Asignatura(
                        nombre: nombreController.text,
                        duracion: int.parse(duracionController.text),
                        campusId: int.parse(campusidController.text),
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
      ),
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