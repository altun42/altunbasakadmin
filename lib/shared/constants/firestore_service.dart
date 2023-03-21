import 'package:altunbasakadmin/shared/constants/data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<Data>> getStreamData() {
    return _db.collection("homeAds").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Data.fromFirestore(doc)).toList());
  }
}
