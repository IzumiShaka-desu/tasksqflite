import 'package:flutter/material.dart';
import 'package:tasksqflite/core/data/database/database.dart';
import 'package:tasksqflite/core/data/models/pegawai.dart';

class DatabaseService {
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() => _singleton;

  DatabaseService._internal();

  static final DatabaseService instance = DatabaseService();

  static final DbHelper _helper = DbHelper.instance;

  Future<bool> deletePegawai(int idWorker) async {
    try {
      return (await _helper.deletePegawai(idWorker));
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> addPegawai(Pegawai newWorker) async {
    try {
      return (await _helper.insert(newWorker)) > 0;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> updatePegawai(Pegawai newWorker) async {
    try {
      return (await _helper.update(newWorker)) > 0;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<List<Pegawai>> getPegawai() async {
    try {
      return (await _helper.getListPegawai()) ?? [];
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<bool> register(String email, String password) async {
    try {
      return (await _helper.register(email, password)) > 0;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
  Future<bool> login(String email, String password) async {
    try {
      return (await _helper.login(email, password));
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
