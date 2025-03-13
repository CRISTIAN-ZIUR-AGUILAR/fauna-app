import 'package:flutter/material.dart';
import '../services/animal_service.dart';
import '../models/animal.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';

class AnimalList extends StatefulWidget {
  @override
  _AnimalListState createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> {
  late List<Animal> _animales;
  bool _esSupervisor = false; // ✅ Para verificar si es supervisor

  @override
  void initState() {
    super.initState();
    _cargarAnimales();
    _verificarRol();
  }

  /// ✅ Simular rol (esto debe reemplazarse con lógica real)
  void _verificarRol() {
    setState(() {
      _esSupervisor = true; // ✅ Prueba con true para que se muestre el botón
    });
  }

  /// ✅ Cargar datos desde la lista local
  void _cargarAnimales() {
    _animales = animalService.obtenerAnimales();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Animales',
          style: TextStyle(fontSize: responsive.scaleText(20)),
        ),
        actions: [
          if (_esSupervisor) // ✅ Mostrar el botón solo si es supervisor
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.pushNamed(context, '/add');
                setState(() {
                  _cargarAnimales(); // ✅ Recargar datos después de agregar
                });
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _cerrarSesion(context),
          ),
        ],
      ),
      body: _animales.isEmpty
          ? Center(
        child: Text(
          'No hay animales registrados.',
          style: TextStyle(
            fontSize: responsive.scaleText(18),
            color: Colors.grey,
          ),
        ),
      )
          : Responsive.isDesktop(context)
          ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // ✅ 2 columnas en escritorio
          childAspectRatio: 1.5,
          crossAxisSpacing: responsive.scale(12),
          mainAxisSpacing: responsive.scale(12),
        ),
        itemCount: _animales.length,
        itemBuilder: (context, index) {
          final animal = _animales[index];
          return _buildCard(animal, responsive);
        },
      )
          : ListView.builder(
        itemCount: _animales.length,
        itemBuilder: (context, index) {
          final animal = _animales[index];
          return _buildCard(animal, responsive);
        },
      ),
    );
  }

  /// ✅ Tarjeta de cada animal
  Widget _buildCard(Animal animal, Responsive responsive) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: responsive.scale(12),
        vertical: responsive.scale(6),
      ),
      elevation: responsive.scale(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.scale(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(responsive.scale(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Imagen desde URL
            ClipRRect(
              borderRadius: BorderRadius.circular(responsive.scale(12)),
              child: Image.network(
                animal.imagenUrl,
                width: double.infinity,
                height: responsive.scale(180),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: responsive.scale(180),
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.broken_image,
                      size: responsive.scale(50),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: responsive.scale(12)),

            // ✅ Mostrar nombre y estado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  animal.nombre,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.scaleText(18),
                  ),
                ),
                Text(
                  animal.estado ?? 'Pendiente',
                  style: TextStyle(
                    color: _getEstadoColor(animal.estado),
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.scaleText(14),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.scale(4)),

            // ✅ Datos adicionales
            Text(
              'Nombre científico: ${animal.nombreCientifico}',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: responsive.scaleText(14),
              ),
            ),
            Text(
              'Proyecto: ${animal.proyecto}',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: responsive.scaleText(14),
              ),
            ),
            Text(
              'Localidad: ${animal.localidad}',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: responsive.scaleText(14),
              ),
            ),
            Text(
              'Fecha de registro: ${_formatFecha(animal.fechaRegistro)}',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: responsive.scaleText(14),
              ),
            ),
            SizedBox(height: responsive.scale(12)),
          ],
        ),
      ),
    );
  }

  /// ✅ Función para determinar el color del estado
  Color _getEstadoColor(String? estado) {
    switch (estado) {
      case 'Aprobado':
        return Colors.green;
      case 'Rechazado':
        return Colors.red;
      case 'Pendiente':
      default:
        return Colors.orange;
    }
  }

  /// ✅ Formatear fecha
  String _formatFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  /// ✅ Cerrar sesión
  void _cerrarSesion(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sesión cerrada'),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pushReplacementNamed(context, '/login');
  }
}
