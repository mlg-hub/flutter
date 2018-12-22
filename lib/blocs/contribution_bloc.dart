import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:advance/models/model.dart';
import 'package:advance/models/Rock.dart';

class ContributionBloc {
  final RockApi rockApi;
  Stream<List<Contribution>> _results = Stream.empty();
  BehaviorSubject<String> _pageName = BehaviorSubject<String>(seedValue: 'unreviewed');
  Stream <List<Contribution>> get results => _results;
  Sink<String> get pageName => _pageName;

  ContributionBloc(this.rockApi) {
    _results = _pageName
    .asyncMap((page) => rockApi.getContributions(pageName: page))
    .asBroadcastStream();
  }
  void dispose() {
    _pageName.close();
  }
}