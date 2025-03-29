//import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/animal.dart';

class AnimalService {
  //final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ✅ Lista privada para almacenar los datos de manera local
  final List<Animal> _animales = [
    Animal(
      id: '1',
      proyecto: 'Proyecto Tigre',
      responsable: 'Carlos Gómez',
      localidad: 'Selva de Chiapas',
      latitud: 16.104,
      longitud: -92.135,
      altitud: 800,
      fechaRegistro: DateTime(2024, 5, 14),
      hora: '10:45 AM',
      nombre: 'Tigre',
      nombreCientifico: 'Panthera tigris',
      familia: 'Felidae',
      clase: 'Mammalia',
      habitat: 'Selva tropical',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlT9k7_Qo6jIsSjXdXX086-5MXQhKSS4zjXKqG7oineDY0kHcxA7m-rkh5QGnUDd84XYVsbMgkgr84IrOdljI4LPEQk5rFOhD0OISzmT4',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Mamífero',
      descripcion: 'Fue visto acechando a una presa en la selva.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '2',
      proyecto: 'Proyecto Águila Real',
      responsable: 'Ana Pérez',
      localidad: 'Montañas de Oaxaca',
      latitud: 17.065,
      longitud: -96.725,
      altitud: 1500,
      fechaRegistro: DateTime(2024, 5, 18),
      hora: '2:30 PM',
      nombre: 'Águila Real',
      nombreCientifico: 'Aquila chrysaetos',
      familia: 'Accipitridae',
      clase: 'Aves',
      habitat: 'Montañas',
      imagenUrl: 'https://static.inaturalist.org/photos/168362446/large.jpg',
      sexo: 'Hembra',
      edad: 'Adulto',
      tipoVertebrado: 'Ave',
      descripcion: 'Visto volando alto en busca de presas.',
      estado: 'Aprobado',
    ),
    Animal(
      id: '3',
      proyecto: 'Proyecto Lobo Mexicano',
      responsable: 'Raúl Martínez',
      localidad: 'Sierra Madre Occidental',
      latitud: 23.623,
      longitud: -106.222,
      altitud: 2100,
      fechaRegistro: DateTime(2024, 5, 21),
      hora: '8:15 AM',
      nombre: 'Lobo Mexicano',
      nombreCientifico: 'Canis lupus baileyi',
      familia: 'Canidae',
      clase: 'Mammalia',
      habitat: 'Bosque',
      imagenUrl: 'https://inaturalist-open-data.s3.amazonaws.com/photos/91801610/large.jpg',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Mamífero',
      descripcion: 'Fue avistado moviéndose en manada.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '4',
      proyecto: 'Proyecto Jaguar',
      responsable: 'Andrea Hernández',
      localidad: 'Selva Lacandona',
      latitud: 16.245,
      longitud: -92.138,
      altitud: 850,
      fechaRegistro: DateTime(2024, 5, 24),
      hora: '11:30 AM',
      nombre: 'Jaguar',
      nombreCientifico: 'Panthera onca',
      familia: 'Felidae',
      clase: 'Mammalia',
      habitat: 'Selva tropical',
      imagenUrl: 'https://static.inaturalist.org/photos/51015966/large.jpg',
      sexo: 'Hembra',
      edad: 'Adulto',
      tipoVertebrado: 'Mamífero',
      descripcion: 'Vista descansando sobre una rama de un árbol.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '5',
      proyecto: 'Proyecto Colibrí',
      responsable: 'Luis García',
      localidad: 'Bosque de Niebla',
      latitud: 19.561,
      longitud: -96.910,
      altitud: 1800,
      fechaRegistro: DateTime(2024, 5, 30),
      hora: '9:00 AM',
      nombre: 'Colibrí Esmeralda',
      nombreCientifico: 'Amazilia cyanocephala',
      familia: 'Trochilidae',
      clase: 'Aves',
      habitat: 'Bosque húmedo',
      imagenUrl: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQf4b_VkIm81FeAViIKTuwcrHo2sHnL0oDaQpAgd5-tiy0II65SWfbn0WIAoY3Lcj-vGcvZ_WOdKWNWhg7DrDRmMA',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Ave',
      descripcion: 'Fue visto alimentándose de néctar en una flor.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '6',
      proyecto: 'Proyecto Cocodrilo',
      responsable: 'Miguel Fernández',
      localidad: 'Río Grijalva',
      latitud: 17.993,
      longitud: -93.150,
      altitud: 20,
      fechaRegistro: DateTime(2024, 6, 3),
      hora: '4:30 PM',
      nombre: 'Cocodrilo de Pantano',
      nombreCientifico: 'Crocodylus moreletii',
      familia: 'Crocodylidae',
      clase: 'Reptilia',
      habitat: 'Río',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTDwD0TRKTJhaXZxFWN4nqK0VG84OCeLvqr8MegUG-t-UUa4bRmIP72XJH9YpUFqIPYb08L2u1CsU15zZCcNcRhKBS0-ZJG7T8InKZ9g',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Reptil',
      descripcion: 'Avistado descansando a la orilla del río.',
      estado: 'Aprobado',
    ),
    Animal(
      id: '7',
      proyecto: 'Proyecto Tortuga',
      responsable: 'Roberto Hernández',
      localidad: 'Costa del Pacífico',
      latitud: 15.260,
      longitud: -96.820,
      altitud: 0,
      fechaRegistro: DateTime(2024, 6, 10),
      hora: '6:00 AM',
      nombre: 'Tortuga Marina',
      nombreCientifico: 'Chelonia mydas',
      familia: 'Cheloniidae',
      clase: 'Reptilia',
      habitat: 'Océano',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9NkJSZYOmx6BIb2lb-jXycMgGS1Ank-Jm6kASQHZJqlwG4oadJwI5M42sET4kPjteAc-efyrRGWlqGAuDSYmxnQ',
      sexo: 'Hembra',
      edad: 'Joven',
      tipoVertebrado: 'Reptil',
      descripcion: 'Fue vista desovando en la arena.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '8',
      proyecto: 'Proyecto Delfín',
      responsable: 'Pedro López',
      localidad: 'Costa del Pacífico',
      latitud: 15.280,
      longitud: -97.321,
      altitud: 0,
      fechaRegistro: DateTime(2024, 6, 12),
      hora: '11:30 AM',
      nombre: 'Delfín Nariz de Botella',
      nombreCientifico: 'Tursiops truncatus',
      familia: 'Delphinidae',
      clase: 'Mammalia',
      habitat: 'Océano',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_MtWqCEhpYRb6nb0voWZttSCd6F3ep7L72pN67h6wC7r8vCUrMi2kQ7kqVTLbx1lR3RkkntUXVyTcE7V2iaWoOQ',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Mamífero',
      descripcion: 'Nadando en grupo en aguas abiertas.',
      estado: 'Aprobado',
    ),

    Animal(
      id: '9',
      proyecto: 'Proyecto Mono Araña',
      responsable: 'Carlos Herrera',
      localidad: 'Selva Lacandona',
      latitud: 16.124,
      longitud: -92.245,
      altitud: 850,
      fechaRegistro: DateTime(2024, 7, 12),
      hora: '3:15 PM',
      nombre: 'Mono Araña',
      nombreCientifico: 'Ateles geoffroyi',
      familia: 'Atelidae',
      clase: 'Mammalia',
      habitat: 'Selva tropical',
      imagenUrl: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR6w2lDcjxyW0VTeESJCy7ig1-QgaN_gkLOCADahC58a2bwaI5KW8IhUcb3six9kCMBf-flaKI4Q8ZoYyXJNzI2Pg',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Mamífero',
      descripcion: 'Visto columpiándose entre las ramas.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '10',
      proyecto: 'Proyecto Cocodrilo',
      responsable: 'María Rojas',
      localidad: 'Pantano de Oaxaca',
      latitud: 15.780,
      longitud: -96.234,
      altitud: 5,
      fechaRegistro: DateTime(2024, 7, 15),
      hora: '1:30 PM',
      nombre: 'Cocodrilo de Río',
      nombreCientifico: 'Crocodylus acutus',
      familia: 'Crocodylidae',
      clase: 'Reptilia',
      habitat: 'Pantano',
      imagenUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQHzONnhev9vdTFziHS4ey_VRdLmCOoxApihk_P2BkHCVGuorBlFW9kRaNmj2t-HTfCqdUeybZCpJOWnlzifI-KMw',
      sexo: 'Hembra',
      edad: 'Adulto',
      tipoVertebrado: 'Reptil',
      descripcion: 'Fue visto descansando en la orilla del río.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '11',
      proyecto: 'Proyecto Loro Cabeza Amarilla',
      responsable: 'Fernando Martínez',
      localidad: 'Selva Baja',
      latitud: 18.524,
      longitud: -94.123,
      altitud: 250,
      fechaRegistro: DateTime(2024, 7, 20),
      hora: '9:45 AM',
      nombre: 'Loro Cabeza Amarilla',
      nombreCientifico: 'Amazona oratrix',
      familia: 'Psittacidae',
      clase: 'Aves',
      habitat: 'Selva',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX5s7aIfVtDeqO2gMPVqYm2Gvh5gH9MNmTfmPFStlXXI-68RoaBpJaNTXg315LEgc_XWgM3erU4QY2GwuxeUijaQ',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Ave',
      descripcion: 'Avistado en un árbol de frutas.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '12',
      proyecto: 'Proyecto Tiburón Blanco',
      responsable: 'Luis Aguilar',
      localidad: 'Océano Pacífico',
      latitud: 14.780,
      longitud: -101.321,
      altitud: 0,
      fechaRegistro: DateTime(2024, 8, 5),
      hora: '2:00 PM',
      nombre: 'Tiburón Blanco',
      nombreCientifico: 'Carcharodon carcharias',
      familia: 'Lamnidae',
      clase: 'Chondrichthyes',
      habitat: 'Océano',
      imagenUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQ9prIKOaDLMnbhgeBmEDIMc8Edaih5pdoRcoRfILIZTu4vITF1rSGHnvM98KJ4alVbwvPE7Ee7Qag2welb8Ht8fw',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Pez',
      descripcion: 'Avistado nadando cerca de la superficie.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '13',
      proyecto: 'Proyecto Zorro Gris',
      responsable: 'Erika Salgado',
      localidad: 'Bosque de Encino',
      latitud: 18.650,
      longitud: -93.875,
      altitud: 1200,
      fechaRegistro: DateTime(2024, 8, 10),
      hora: '6:00 PM',
      nombre: 'Zorro Gris',
      nombreCientifico: 'Urocyon cinereoargenteus',
      familia: 'Canidae',
      clase: 'Mammalia',
      habitat: 'Bosque',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRor63Kc5FqoXP2zMCGUDbrLpmWWDzvr8wGxF2lAo7cLyKaBogpg6TN1j28FQWh_5XEcK3HIWUGgR0ndr0JsKeUYg',
      sexo: 'Hembra',
      edad: 'Adulto',
      tipoVertebrado: 'Mamífero',
      descripcion: 'Avistado cerca de una cueva.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '14',
      proyecto: 'Proyecto Tortuga Laúd',
      responsable: 'José Martínez',
      localidad: 'Playa de Oaxaca',
      latitud: 15.634,
      longitud: -96.723,
      altitud: 0,
      fechaRegistro: DateTime(2024, 8, 15),
      hora: '11:30 PM',
      nombre: 'Tortuga Laúd',
      nombreCientifico: 'Dermochelys coriacea',
      familia: 'Dermochelyidae',
      clase: 'Reptilia',
      habitat: 'Playa',
      imagenUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSbPlOWuwqx8hbjkj27TQ_SjnAGSTi9Bj-ESWlQxYJWD3zd_3dYNTj8oNz28MtDXT4H4AA_f_QAeckyvWTjzePjdg',
      sexo: 'Hembra',
      edad: 'Adulto',
      tipoVertebrado: 'Reptil',
      descripcion: 'Visto desovando en la playa.',
      estado: 'Pendiente',
    ),
    Animal(
      id: '15',
      proyecto: 'Proyecto Rana Arborícola',
      responsable: 'Daniel Torres',
      localidad: 'Selva Húmeda',
      latitud: 16.782,
      longitud: -92.401,
      altitud: 600,
      fechaRegistro: DateTime(2024, 8, 20),
      hora: '8:00 PM',
      nombre: 'Rana Arborícola',
      nombreCientifico: 'Agalychnis callidryas',
      familia: 'Hylidae',
      clase: 'Amphibia',
      habitat: 'Selva',
      imagenUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Red_eyed_tree_frog_edit2.jpg/1280px-Red_eyed_tree_frog_edit2.jpg',
      sexo: 'Macho',
      edad: 'Adulto',
      tipoVertebrado: 'Anfibio',
      descripcion: 'Visto en una hoja cerca de un estanque.',
      estado: 'Pendiente',
    ),
  ];

  // ✅ Método para obtener la lista de animales
  List<Animal> obtenerAnimales() {
    return _animales;
  }

  // ✅ Método para actualizar el estado localmente
  void actualizarEstadoAnimal(String id, String nuevoEstado) {
    final index = _animales.indexWhere((animal) => animal.id == id);
    if (index != -1) {
      _animales[index].estado = nuevoEstado;
      print('Estado actualizado: ${_animales[index].nombre} -> $nuevoEstado');
    }
  }

  // ✅ Método para eliminar un animal
  void eliminarAnimal(String id) {
    _animales.removeWhere((animal) => animal.id == id);
    print('Animal eliminado con ID: $id');
  }

  // ✅ Método para añadir un animal a la lista
  void agregarAnimalLocal(Animal animal) {
    _animales.add(animal);
    print('Animal añadido: ${animal.nombre}');
  }
}

final animalService = AnimalService();

