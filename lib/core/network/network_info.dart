import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

abstract class NetWorkInfoI{
  Future<bool> isConnected();
  Future<List<ConnectivityResult>> get connectivityResult;
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

class NetWorkInfo implements NetWorkInfoI{
  late Connectivity connectivity;

  static final NetWorkInfo _netWorkInfo = NetWorkInfo._internal(Connectivity());

  factory NetWorkInfo(){
    return _netWorkInfo;
  }

  NetWorkInfo._internal(this.connectivity){
    connectivity = this.connectivity;
  }

  @override
  Future<bool> isConnected() async{
    final result = await connectivityResult;
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Future<List<ConnectivityResult>> get connectivityResult async{
    return connectivity.checkConnectivity();
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;
}

abstract class Failure {}

class ServerFailure extends Failure{}
class CacheFailure extends Failure{}
class NetworkFailure extends Failure{}
class ServerException implements Exception{}
class CacheException implements Exception{}
class NetworkException implements Exception{}


class NoInternetException implements Exception{
  late String _message;

  NoInternetException(dynamic globalMessengerKey, [String message = "NoInternetException Occurred"]) {
    if(globalMessengerKey.currentState != null){
      globalMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
    }
    this._message = message;
  }

  @override
  String toString(){
    return _message;
  }
}