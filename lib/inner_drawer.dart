import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:reff/core/utils/debugs.dart';

enum DrawerSide { left, right }

final innerDrawerStateProvider = Provider((_) => GlobalKey<InnerDrawerState>());

final buildNumberFutureProvider =
    FutureProvider((_) async => await PackageInfo.fromPlatform());

class CustomInnerDrawer extends HookWidget {
  const CustomInnerDrawer({@required this.scaffold}) : assert(scaffold != null);

  final Scaffold scaffold;

  @override
  Widget build(BuildContext context) {
    final key = useProvider(innerDrawerStateProvider);
    final buildNumberFuture = useProvider(buildNumberFutureProvider);

    return InnerDrawer(
        key: key,
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
                      buildNumberFuture.maybeWhen(
                          data: (data) => Text('build  ${data.buildNumber}'),
                          orElse: () => SizedBox.shrink()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        leftChild: Scaffold(
          body: Column(
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
