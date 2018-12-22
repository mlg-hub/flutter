import 'package:advance/Components/Listpage.dart';
import 'package:advance/Components/infoDrawer.dart';
import 'package:advance/blocs/contribution_bloc.dart';
import 'package:advance/blocs/informationBloc.dart';
import 'package:advance/models/GIthupApi.dart';
import 'package:advance/models/Rock.dart';
import 'package:advance/models/model.dart';
import 'package:advance/providers/ContributionsProvider.dart';
import 'package:advance/providers/informationProvider.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ContributionsProvider(
      contributionBloc: ContributionBloc(RockApi()),
      child: RootApp(),
    );
  }
}


class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contributionBloc = ContributionsProvider.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Utopian Rocks Mobile',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Utopian Rocks Mobile'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.rate_review),
                  text: 'Waiting for Review'
                  ),
                Tab(
                  icon: Icon(Icons.hourglass_empty),
                  text: 'Waiting on upvote'
                  ),

              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPage(pageName: 'unreviewed',
              bloc: contributionBloc),
              ListPage(pageName: 'pending', bloc: contributionBloc),
            ],
          ),
        endDrawer: InformationProvider(
          informationBloc: InformationBloc(
            PackageInfo.fromPlatform(),
            GithubApi(),
          ),
          child: InformationDrawer()),
        ),
      )
    );
}
}