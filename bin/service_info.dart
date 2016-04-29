//TODO copyright
import 'dart:html';
import 'package:uploader/uploader.dart';
//import '../lib/server/server.dart';

class ServiceInfo {
  TableCellElement serviceName;
  TableCellElement hostname;
  TableCellElement ipAddress;


  ServiceInfo() {
    serviceName = document.querySelector('#service-name');
    hostname = document.querySelector('#hostname');
    ipAddress = document.querySelector('#ipAddress');

    serviceName.text = 'ODW Login Server';
    print('name: ${Server.hostname}');
    hostname.text = Server.hostname;
    ipAddress.text = Server.ipAddresses;
    // _fileInput.onChange.listen((e) => _onFileInputChange());

  }
}

void main() {
  var info = new ServiceInfo();

}
