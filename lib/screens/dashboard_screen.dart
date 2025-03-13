import 'package:flutter/material.dart';
import '../services/animal_service.dart';
import '../models/animal.dart';
import '../utils/responsive.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<Animal> _animales;

  @override
  void initState() {
    super.initState();
    _cargarAnimales();
  }

  /// ✅ Cargar datos desde AnimalService
  void _cargarAnimales() {
    _animales = animalService.obtenerAnimales();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Panel de Supervisor',
          style: TextStyle(fontSize: responsive.scaleText(22)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.pushNamed(context, '/add');
              setState(() {
                _cargarAnimales(); // ✅ Refrescar lista después de agregar
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _cerrarSesion(context),
          ),
        ],
      ),
      drawer: _buildDrawer(responsive),
      body: _animales.isEmpty
          ? Center(
        child: Text(
          'No hay registros disponibles',
          style: TextStyle(
            fontSize: responsive.scaleText(18),
            color: Colors.grey,
          ),
        ),
      )
          : Responsive.isDesktop(context)
          ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
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

  /// ✅ Barra lateral para opciones
  Widget _buildDrawer(Responsive responsive) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            child: Text(
              'Opciones de Supervisor',
              style: TextStyle(
                color: Colors.white,
                fontSize: responsive.scaleText(18),
              ),
            ),
          ),
          // ✅ Nueva opción para mostrar todos los registros
          _buildDrawerItem(
            icon: Icons.list,
            text: 'Mostrar Todo',
            onTap: () => _mostrarTodos(),
            responsive: responsive,
          ),
          _buildDrawerItem(
            icon: Icons.check_circle,
            text: 'Ver Aprobados',
            onTap: () => _filtrarEstado('Aprobado'),
            responsive: responsive,
          ),
          _buildDrawerItem(
            icon: Icons.pending_actions,
            text: 'Ver Pendientes',
            onTap: () => _filtrarEstado('Pendiente'),
            responsive: responsive,
          ),
          _buildDrawerItem(
            icon: Icons.cancel,
            text: 'Ver Rechazados',
            onTap: () => _filtrarEstado('Rechazado'),
            responsive: responsive,
          ),
        ],
      ),
    );
  }

  /// ✅ Mostrar todos los registros
  void _mostrarTodos() {
    setState(() {
      _animales = animalService.obtenerAnimales();
    });
    Navigator.pop(context);
  }


  /// ✅ Opciones en la barra lateral
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Responsive responsive,
  }) {
    return ListTile(
      leading: Icon(icon, size: responsive.scale(24), color: Colors.blueAccent),
      title: Text(
        text,
        style: TextStyle(fontSize: responsive.scaleText(16)),
      ),
      onTap: onTap,
    );
  }

  /// ✅ Filtrar por estado
  void _filtrarEstado(String estado) {
    setState(() {
      _animales = animalService
          .obtenerAnimales()
          .where((animal) => animal.estado == estado)
          .toList();
    });
    Navigator.pop(context);
  }

  /// ✅ Tarjeta para cada animal
  Widget _buildCard(Animal animal, Responsive responsive) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: responsive.scale(12),
        vertical: responsive.scale(6),
      ),
      elevation: responsive.scale(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.scale(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(responsive.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Imagen del animal
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
            const SizedBox(height: 10),

            // ✅ Información del animal
            Text(
              animal.nombre,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: responsive.scaleText(20),
              ),
            ),

            Text(
              'Estado: ${animal.estado}',
              style: TextStyle(
                color: _getEstadoColor(animal.estado),
                fontWeight: FontWeight.bold,
                fontSize: responsive.scaleText(16),
              ),
            ),
            const SizedBox(height: 8),

            _buildInfoRow('Nombre Científico', animal.nombreCientifico, responsive),
            _buildInfoRow('Proyecto', animal.proyecto, responsive),
            _buildInfoRow('Localidad', animal.localidad, responsive),
            _buildInfoRow(
                'Fecha de registro', _formatFecha(animal.fechaRegistro), responsive),

            if (animal.estado == 'Pendiente') _buildActionButtons(animal, responsive),
          ],
        ),
      ),
    );
  }

  /// ✅ Botones de acción mejorados
  Widget _buildActionButtons(Animal animal, Responsive responsive) {
    final isMobile = !Responsive.isDesktop(context); // ✅ Verifica si es móvil

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? responsive.scale(8) : responsive.scale(12),
              horizontal: isMobile ? responsive.scale(12) : responsive.scale(20),
            ),
            textStyle: TextStyle(
              fontSize: responsive.scaleText(isMobile ? 12 : 16),
            ),
          ),
          icon: Icon(Icons.check, size: responsive.scale(isMobile ? 18 : 24)),
          label: Text('Aprobar'),
          onPressed: () => _aprobarRegistro(animal),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? responsive.scale(8) : responsive.scale(12),
              horizontal: isMobile ? responsive.scale(12) : responsive.scale(20),
            ),
            textStyle: TextStyle(
              fontSize: responsive.scaleText(isMobile ? 12 : 16),
            ),
          ),
          icon: Icon(Icons.cancel, size: responsive.scale(isMobile ? 18 : 24)),
          label: Text('Rechazar'),
          onPressed: () => _rechazarRegistro(animal),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? responsive.scale(8) : responsive.scale(12),
              horizontal: isMobile ? responsive.scale(12) : responsive.scale(20),
            ),
            textStyle: TextStyle(
              fontSize: responsive.scaleText(isMobile ? 12 : 16),
            ),
          ),
          icon: Icon(Icons.delete, size: responsive.scale(isMobile ? 18 : 24)),
          label: Text('Eliminar'),
          onPressed: () => _eliminarRegistro(animal),
        ),
      ],
    );
  }

  ///  Mostrar información de manera ordenada
  Widget _buildInfoRow(String label, String value, Responsive responsive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: responsive.scaleText(14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: responsive.scaleText(14)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Aprobar registro
  void _aprobarRegistro(Animal animal) {
    setState(() {
      animalService.actualizarEstadoAnimal(animal.id, 'Aprobado');
    });
  }

  /// ✅ Rechazar registro
  void _rechazarRegistro(Animal animal) {
    setState(() {
      animalService.actualizarEstadoAnimal(animal.id, 'Rechazado');
    });
  }

  /// ✅ Eliminar registro
  void _eliminarRegistro(Animal animal) {
    setState(() {
      animalService.eliminarAnimal(animal.id);
    });
  }

  String _formatFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  void _cerrarSesion(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  Color _getEstadoColor(String? estado) {
    switch (estado) {
      case 'Aprobado':
        return Colors.green;
      case 'Rechazado':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
