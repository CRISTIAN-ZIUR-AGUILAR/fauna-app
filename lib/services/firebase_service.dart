import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ✅ Subir imagen a Firebase Storage
  Future<String?> subirImagen(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('animales/$fileName.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error al subir imagen: $e');
      return null;
    }
  }

  // ✅ Guardar datos en Firestore
  Future<void> registrarAnimal(Map<String, dynamic> datos) async {
    try {
      await _db.collection('animales').add(datos);
      print('✅ Animal registrado en Firestore');
    } catch (e) {
      print('❌ Error al registrar el animal: $e');
    }
  }
}

final firebaseService = FirebaseService(); // ✅ Instancia global
