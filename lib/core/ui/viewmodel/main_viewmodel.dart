import 'package:flutter/material.dart';
import 'package:tasksqflite/components/molecules/dialog_loading_progress.dart';
import 'package:tasksqflite/core/data/models/pegawai.dart';
import 'package:tasksqflite/core/data/service/database_service.dart';
import 'package:tasksqflite/core/data/service/local_service.dart';

class MainViewModel extends ChangeNotifier {
  List<Pegawai> _workers;
  List<Pegawai> get workers => _workers;

  bool _isLogin;
  bool get isLogin => _isLogin;

  String _email;
  String get email => _email;

  final DatabaseService _dbService = DatabaseService.instance;
  final LocalService _localService = LocalService.instance;

  MainViewModel() {
    loadLoginDetails();
  }
  void refresh() {
    notifyListeners();
  }

  Future loadLoginDetails() async {
    _isLogin = await _localService.isLogin();
    if (_isLogin) {
      var _loginDetails = await _localService.getLoginDetails();
      _email = _loginDetails['email'];
    }
    notifyListeners();
  }

  Future loadWorkersList() async {
    _workers = await _dbService.getPegawai();
    notifyListeners();
  }

  Future addWorkers(Pegawai newWorker, BuildContext context) async {
    bool _isSuccess = await _dbService.addPegawai(newWorker);
    if (_isSuccess) {
      loadWorkersList();
      Dialogs.showSnackbar(context, "berhasil menambahkan pegawai");
    } else {
      Dialogs.showSnackbar(context, "berhasil menambahkan pegawai");
    }
  }

  Future updateWorkers(Pegawai newWorker, BuildContext context) async {
    bool _isSuccess = await _dbService.updatePegawai(newWorker);
    if (_isSuccess) {
      loadWorkersList();
      Dialogs.showSnackbar(context, "berhasil mengedit pegawai");
    } else {
      Dialogs.showSnackbar(context, "tidak berhasil mengedit pegawai");
    }
  }

  Future<Pegawai> deleteWorkers(int idWorker, BuildContext context) async {
    debugPrint(idWorker.toString());
    bool _isSuccess = await _dbService.deletePegawai(idWorker);
    if (_isSuccess) {
      Dialogs.showSnackbar(context, "berhasil menghapus pegawai");
      return workers.removeAt(
          workers.indexWhere((element) => element.idPegawai == idWorker));
    } else {
      Dialogs.showSnackbar(context, "tidak berhasil menghapus pegawai");
    }
    return null;
  }
}
