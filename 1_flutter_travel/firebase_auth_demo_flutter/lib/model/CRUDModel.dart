import 'dart:async';
import 'package:firebase_auth_demo_flutter/model/Api.dart';
import 'package:firebase_auth_demo_flutter/model/EnrollmentDto.dart';
import 'package:firebase_auth_demo_flutter/Locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<EnrollmentDto> enrollmentDtos;

  Future<List<EnrollmentDto>> fetchEnrollmentDtos() async {
    var result = await _api.getDataCollection();
    enrollmentDtos = result.documents
        .map((doc) => EnrollmentDto.fromMap(doc.data, doc.documentID))
        .toList();
    return enrollmentDtos;
  }

  Stream<QuerySnapshot> fetchEnrollmentDtosAsStream() {
    return _api.streamDataCollection();
  }

  Future<EnrollmentDto> getEnrollmentDtoById(String id) async {
    var doc = await _api.getDocumentById(id);
    return EnrollmentDto.fromMap(doc.data, doc.documentID);
  }

  Future removeEnrollmentDto(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateEnrollmentDto(EnrollmentDto data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addEnrollmentDto(EnrollmentDto data) async {
    var result = await _api.addDocument(data.toJson(), data.uId);
    return;
  }
}
