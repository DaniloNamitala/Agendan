import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Arquivo {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Directory> _abrePasta(String path) async {
    var dir = Directory(path);
    return await dir.exists().then((value) {
      if (!value) dir.create();
      return dir;
    });
  }

  Future<List> listaArquivos(String path) async {
    List<Map<String, dynamic>> list = List();
    var lista =
        await _abrePasta(path).then((Directory value) => value.listSync());
    lista.forEach((element) {
      list.add({
        'nome': element.path.toString().split('/')[7],
        'data': File(element.path.toString()).lastModifiedSync()
      });
    });
    return (list);
  }
}
