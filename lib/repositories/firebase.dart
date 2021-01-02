import 'tips.dart';
import '../models/tip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class TipRepositoryFirestore extends TipRepository {
  final _loadedData = StreamController<List<Tip>>();

  final List<Tip> _cache = [];

  @override
  void dispose() {
    _loadedData.close();
  }

  @override
  void refresh() {
    if (FirebaseFirestore.instance != null) {
      FirebaseFirestore.instance
          .collection('tips')
          .snapshots()
          .listen((techniques) {
        _cache.clear();
        techniques.docs.forEach((tip) {
          final doc = tip.data();
          _cache.add(
              Tip(doc["tipName"], doc["shortTipText"], doc["fullTipText"]));
        });

        _loadedData.add(_cache);
      });
    }
  }

  @override
  Stream<List<Tip>> tips() => _loadedData.stream;
}
