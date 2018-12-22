


import 'package:advance/blocs/contribution_bloc.dart';
import 'package:advance/models/model.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;
  

  const ListPage({Key key, this.bloc, this.pageName}) : super(key: key);@override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);

    return StreamBuilder(
      stream: bloc.results,
      builder: (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (contenxt, index) => ListTile(
            title: Text('${snapshot.data[index].title}'),
          ),
        );
      },
    );
  }
}