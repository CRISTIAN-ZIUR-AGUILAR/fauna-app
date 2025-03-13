class Animal {
  String id;
  String proyecto;
  String responsable;
  String localidad;
  double latitud;
  double longitud;
  double altitud;
  DateTime fechaRegistro;
  String hora;
  String nombre;
  String nombreCientifico;
  String familia;
  String clase;
  String habitat;
  String imagenUrl;
  String sexo;
  String edad;
  String tipoVertebrado;
  String descripcion;
  String estado;

  Animal({
    required this.id,
    required this.proyecto,
    required this.responsable,
    required this.localidad,
    required this.latitud,
    required this.longitud,
    required this.altitud,
    required this.fechaRegistro,
    required this.hora,
    required this.nombre,
    required this.nombreCientifico,
    required this.familia,
    required this.clase,
    required this.habitat,
    required this.imagenUrl,
    required this.sexo,
    required this.edad,
    required this.tipoVertebrado,
    required this.descripcion,
    required this.estado,
  });

  // ✅ Método para convertir el objeto a un Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proyecto': proyecto,
      'responsable': responsable,
      'localidad': localidad,
      'latitud': latitud,
      'longitud': longitud,
      'altitud': altitud,
      'fechaRegistro': fechaRegistro.toIso8601String(),
      'hora': hora,
      'nombre': nombre,
      'nombreCientifico': nombreCientifico,
      'familia': familia,
      'clase': clase,
      'habitat': habitat,
      'imagenUrl': imagenUrl,
      'sexo': sexo,
      'edad': edad,
      'tipoVertebrado': tipoVertebrado,
      'descripcion': descripcion,
      'estado': estado,
    };
  }

  // ✅ Método para convertir un Map a un objeto Animal (desde Firestore)
  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      id: map['id'] ?? '',
      proyecto: map['proyecto'] ?? '',
      responsable: map['responsable'] ?? '',
      localidad: map['localidad'] ?? '',
      latitud: (map['latitud'] ?? 0).toDouble(),
      longitud: (map['longitud'] ?? 0).toDouble(),
      altitud: (map['altitud'] ?? 0).toDouble(),
      fechaRegistro: DateTime.parse(map['fechaRegistro']),
      hora: map['hora'] ?? '',
      nombre: map['nombre'] ?? '',
      nombreCientifico: map['nombreCientifico'] ?? '',
      familia: map['familia'] ?? '',
      clase: map['clase'] ?? '',
      habitat: map['habitat'] ?? '',
      imagenUrl: map['imagenUrl'] ?? '',
      sexo: map['sexo'] ?? '',
      edad: map['edad'] ?? '',
      tipoVertebrado: map['tipoVertebrado'] ?? '',
      descripcion: map['descripcion'] ?? '',
      estado: map['estado'] ?? 'Pendiente',
    );
  }
}
