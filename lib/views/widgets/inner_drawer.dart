import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:reff/core/utils/debugs.dart';

enum DrawerSide { left, right }

final innerDrawerStateProvider = Provider((_) => GlobalKey<InnerDrawerState>());

class InnerDrawerScope extends HookWidget {
  InnerDrawerScope({@required this.scaffold}) : assert(scaffold != null);

  final Scaffold scaffold;
  final _logger = Logger("InnerDrawerScope");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");
    final buildNumberFuture = useFuture(useMemoized(PackageInfo.fromPlatform));

    return InnerDrawer(
        key: context.read(innerDrawerStateProvider),
        scaffold: scaffold,
        onTapClose: true,
        swipe: false,
        rightChild: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(''),
                Divider(color: Colors.transparent),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: listTiles.length,
                    itemBuilder: (context, index) {
                      final tile = listTiles[index];
                      return tile;
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Divider(),
                      Text('Kare Agency'),
                      Divider(color: Colors.transparent),
                      _buildBuildNumber(buildNumberFuture),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        leftChild: Container(
          color: Theme
              .of(context)
              .scaffoldBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Debug Menu',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              RaisedButton.icon(
                  onPressed: () => deleteUser(context),
                  icon: Icon(Icons.delete),
                  label: Text('Kullanıcıyı kaldır.')),
              RaisedButton.icon(
                  onPressed: () => deleteVotes(context),
                  icon: Icon(Icons.delete),
                  label: Text('Oyları sil.')),
              Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Text('İşlemler sonrası uygulamayı yeniden başlatmanız'
                        ' gerekiyor...'),
                  ))
            ],
          ),
        ));
  }

  Widget _buildBuildNumber(AsyncSnapshot<PackageInfo> snapshot) {
    if (snapshot.hasData) {
      final buildNumber = snapshot.data.buildNumber;
      return Text('build  $buildNumber');
    } else if (snapshot.hasError) {
      return ErrorWidget("${snapshot.error}");
    } else {
      return const SizedBox.shrink();
    }
  }
}

final listTiles = [
  Row(children: [
    Icon(MdiIcons.guyFawkesMask),
    VerticalDivider(),
    Text('Gizlilik Sözleşmesi')
  ]),
  Row(children: [Icon(MdiIcons.share), VerticalDivider(), Text('Paylaş')]),
]
    .map((e) =>
        Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: e))
    .toList();
