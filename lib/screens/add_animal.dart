import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../services/firebase_service.dart';

class AddAnimal extends StatefulWidget {
  @override
  _AddAnimalState createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  final _formKey = GlobalKey<FormState>();

  // ✅ Controladores para Datos de Captura
  final _proyectoController = TextEditingController();
  final _responsableController = TextEditingController();
  final _localidadController = TextEditingController();
  final _latitudController = TextEditingController();
  final _longitudController = TextEditingController();
  final _altitudController = TextEditingController();

  // ✅ Controladores para Datos del Animal
  final _nombreController = TextEditingController();
  final _nombreCientificoController = TextEditingController();
  final _familiaController = TextEditingController();
  final _claseController = TextEditingController();
  final _habitatController = TextEditingController();
  final _descripcionController = TextEditingController();

  String? _sexo;
  String? _edad;
  String? _tipoVertebrado;
  DateTime? _fechaRegistro;
  TimeOfDay? _hora;
  File? _imagen;
  bool _subiendo = false;

  // ✅ Opciones de selección
  final List<String> _vertebrados = ['Mamífero', 'Ave', 'Reptil', 'Anfibio', 'Pez'];
  final List<String> _sexos = ['Macho', 'Hembra', 'Desconocido'];
  final List<String> _edades = ['Juvenil', 'Adulto', 'Desconocido'];

  // ✅ Generar ID automáticamente
  String _generarId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // ✅ Obtener geolocalización automática
  Future<void> _obtenerUbicacion() async {
    bool servicioHabilitado;
    LocationPermission permiso;

    servicioHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHabilitado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El servicio de ubicación está deshabilitado')),
      );
      return;
    }

    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permiso de ubicación denegado')),
        );
        return;
      }
    }

    Position posicion = await Geolocator.getCurrentPosition();
    setState(() {
      _latitudController.text = posicion.latitude.toStringAsFixed(6);
      _longitudController.text = posicion.longitude.toStringAsFixed(6);
      _altitudController.text = posicion.altitude.toStringAsFixed(2);
    });
  }

  // ✅ Seleccionar imagen desde cámara o galería
  Future<void> _seleccionarImagen(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedFile != null) {
      setState(() {
        _imagen = File(pickedFile.path);
      });
    }
  }

  // ✅ Guardar datos en Firestore
  Future<void> _guardarAnimal() async {
    if (_formKey.currentState!.validate() && _imagen != null) {
      setState(() => _subiendo = true);

      // ✅ Subir imagen a Firebase Storage
      String? imagenUrl;
      if (_imagen != null) {
        imagenUrl = await firebaseService.subirImagen(_imagen!);
      }

      // ✅ Datos para Firestore
      final animal = {
        'id': _generarId(),
        'proyecto': _proyectoController.text,
        'responsable': _responsableController.text,
        'localidad': _localidadController.text,
        'latitud': double.parse(_latitudController.text),
        'longitud': double.parse(_longitudController.text),
        'altitud': double.parse(_altitudController.text),
        'fechaRegistro': DateTime.now().toIso8601String(),
        'nombre': _nombreController.text,
        'nombreCientifico': _nombreCientificoController.text,
        'familia': _familiaController.text,
        'clase': _claseController.text,
        'habitat': _habitatController.text,
        'sexo': _sexo ?? '',
        'edad': _edad ?? '',
        'tipoVertebrado': _tipoVertebrado ?? '',
        'descripcion': _descripcionController.text,
        'imagenUrl': imagenUrl ?? '',
      };

      await firebaseService.registrarAnimal(animal);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Animal registrado correctamente')),
      );

      setState(() => _subiendo = false);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Completa todos los campos y sube una imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Animal')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ✅ Datos de Captura
              const Text('📌 Datos de Captura', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildTextField(_proyectoController, 'Proyecto', Icons.work),
              _buildTextField(_responsableController, 'Responsable', Icons.person),
              _buildTextField(_localidadController, 'Localidad', Icons.location_city),

              Row(
                children: [
                  Expanded(child: _buildTextField(_latitudController, 'Latitud', Icons.location_on)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField(_longitudController, 'Longitud', Icons.location_on)),
                ],
              ),
              _buildTextField(_altitudController, 'Altitud (msnm)', Icons.height),

              ElevatedButton(
                onPressed: _obtenerUbicacion,
                child: const Text('Obtener ubicación automática'),
              ),

              // ✅ Datos del Animal
              const SizedBox(height: 20),
              const Text('🦁 Datos del Animal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildTextField(_nombreController, 'Nombre', Icons.pets),
              _buildTextField(_nombreCientificoController, 'Nombre científico', Icons.science),

              _buildDropdown('Sexo', _sexos, _sexo, (value) => setState(() => _sexo = value)),
              _buildDropdown('Edad', _edades, _edad, (value) => setState(() => _edad = value)),
              _buildDropdown('Tipo de Vertebrado', _vertebrados, _tipoVertebrado, (value) => setState(() => _tipoVertebrado = value)),

              _buildTextField(_descripcionController, 'Descripción', Icons.text_fields),

              // ✅ Mostrar imagen seleccionada
              if (_imagen != null)
                Image.file(_imagen!, height: 150, width: 150, fit: BoxFit.cover),

              // ✅ Botones para tomar foto o subir imagen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera),
                    label: const Text('Tomar Foto'),
                    onPressed: () => _seleccionarImagen(ImageSource.camera),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo),
                    label: const Text('Galería'),
                    onPressed: () => _seleccionarImagen(ImageSource.gallery),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              ElevatedButton(onPressed: _guardarAnimal, child: const Text('Guardar')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: label),
      value: selectedValue,
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    );
  }
}
