

import 'package:flutter/material.dart';

import 'package:advance/models/model.dart';
import 'package:advance/providers/informationProvider.dart';
import 'package:advance/blocs/informationBloc.dart';
import 'package:advance/models/GIthupApi.dart';
import 'package:package_info/package_info.dart';

class InformationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Information Drawer',
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          _buildInfoPanel(context),
          Center(),
        ],
      ),
    );
  }
}

_buildInfoPanel(BuildContext ctx) {
  final informationBloc = InformationProvider.of(ctx);
  return Flex(
    direction: Axis.vertical,
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 30.0),
        width: MediaQuery.of(ctx).size.width,
        color: Colors.black,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Information',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ),
        ),
      ),
      StreamBuilder(
        stream: informationBloc.infoStream,
        builder: (ctx, snapshot) {
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          return Flex(
            direction: Axis.vertical,
            children: <Widget>[
              _buildInfoTile(
                '${snapshot.data.appName}',
                subtitle: 
                " Pre-release Version Number: ${snapshot.data.version}",
              ),
              _buildInfoTile(
                'Instuctions: ',
                subtitle: 
                "Double tap on a contribution to open in browser!",
              ),
              _buildInfoTile(
                'Author & Application Info',
                subtitle: 
                "Developped by @tensor. MAny thanks to @morishomlg",
              ),
              RaisedButton(child: Text('check update'),
              onPressed: () => _getNewRelease(ctx, snapshot),)
            ],
          );
        }
      )
    ],
  );
}

Widget _buildInfoTile(String title, {String subtitle}) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.start,
    ),
    subtitle: Text(
      subtitle ?? '',
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600
      )
    )
  );
}

void _getNewRelease(BuildContext context, AsyncSnapshot snapshot) {
  final informationBloc = InformationProvider.of(context);
  informationBloc.releases.listen((release) {
    if(snapshot.data.version.toString() != release.tagName) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('${snapshot.data.appName}'),
          content: Container(child: Text(
            'A new version is available, you current version is' +
            ': ${snapshot.data.version} while the current version is ${release.tagName}'
            ),
          ),
          actions: <Widget>[
            FlatButton(child: Text('Download'),
            onPressed: () => null,
            ),
            FlatButton(child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
            ),

          ],
          ),
        );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('${snapshot.data.appName}'),
          content: Container(
            child: Text('There is no new version at this time'),
          ),
          actions: <Widget>[
             FlatButton(child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
            ),
          ],)
      );
    }

    
  });
}