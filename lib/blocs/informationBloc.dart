
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:advance/models/model.dart';
import 'package:advance/models/GIthupApi.dart';
import 'package:package_info/package_info.dart';

class InformationBloc {
  final Future<PackageInfo> packageInfo;
  final GithubApi api;

  Stream<PackageInfo> _infoStream = Stream.empty();
  Stream<GithubModel> _releases = Stream.empty();

  Stream<PackageInfo> get infoStream => _infoStream;
  Stream<GithubModel> get releases => _releases;
  
  InformationBloc(this.packageInfo, this.api) {
    _releases = Observable.defer(
      () => Observable.fromFuture(api.getReleases()).asBroadcastStream(),
      reusable: true,
    );

    _infoStream = Observable.defer(
      () => Observable.fromFuture(packageInfo).asBroadcastStream(),
      reusable: true,
    );
  }
}