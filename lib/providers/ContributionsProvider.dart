
import 'package:flutter/widgets.dart';
import 'package:advance/blocs/contribution_bloc.dart';
import 'package:advance/models/Rock.dart';


class ContributionsProvider extends InheritedWidget {
  final ContributionBloc contributionBloc;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
  
  static ContributionBloc of(BuildContext context) => 
  (context.inheritFromWidgetOfExactType(ContributionsProvider) as ContributionsProvider).contributionBloc;

  ContributionsProvider({
    Key key,
    ContributionBloc contributionBloc,
    Widget child,
  }) : this.contributionBloc = contributionBloc ??
    ContributionBloc(RockApi()),
    super(child: child, key: key);
}