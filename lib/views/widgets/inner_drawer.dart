import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:reff/core/utils/debugs.dart';
import 'package:reff/views/widgets/privacy_policy_dialog.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final _listTiles = listTiles(context);
    return InnerDrawer(
        key: context.read(innerDrawerStateProvider),
        scaffold: scaffold,
        onTapClose: true,
        swipe: false,
        rightChild: Material(
          child: SafeArea(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        const url = 'https://kareagency.com';
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  "assets/images/kare_agency.png",
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  colorBlendMode: BlendMode.difference,
                                  height: 64),
                            ),
                            // _buildBuildNumber(buildNumberFuture),
                            Text(
                              'Kare Agency',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _listTiles.length,
                      itemBuilder: (context, index) {
                        final tile = _listTiles[index];
                        return tile;
                      },
                      separatorBuilder: (context, index) => Divider(height: 0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildBuildNumber(buildNumberFuture),
                  )
                ],
              ),
            ),
          ),
        ),
        leftChild: Material(
          child: SafeArea(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
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
                        child: Text(
                            'İşlemler sonrası uygulamayı yeniden başlatmanız'
                            ' gerekiyor...'),
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildBuildNumber(AsyncSnapshot<PackageInfo> snapshot) {
    if (snapshot.hasData) {
      final buildNumber = snapshot.data.buildNumber;
      return Text(
        'build  $buildNumber',
        style: TextStyle(fontWeight: FontWeight.w200),
      );
    } else if (snapshot.hasError) {
      return ErrorWidget("${snapshot.error}");
    } else {
      return const SizedBox.shrink();
    }
  }
}

List<ListTile> listTiles(BuildContext context) => [
      ListTile(
          dense: true,
          leading: Icon(MdiIcons.guyFawkesMask),
          onTap: () async {
            showDialog(context: context, builder: (_) => PrivacyPolicyDialog());
          },
          title: Text('Gizlilik Sözleşmesi')),
      ListTile(
          dense: true,
          leading: Icon(Icons.assignment),
          onTap: () async {
            // TODO : kullanım koşulları url
            const url = "kareagency.com";
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
          title: Text('Kullanım Koşulları')),
      ListTile(
          dense: true,
          leading: Icon(MdiIcons.share),
          onTap: () {
            // TODO : share için url
            Share.share("check out this app : kareagency.com");
          },
          title: Text('Paylaş')),
      ListTile(
          dense: true,
          leading: Icon(MdiIcons.star),
          onTap: () async {
            final requestReviewAvailable =
                await AppReview.isRequestReviewAvailable;

            if (requestReviewAvailable) {
              AppReview.writeReview;
            }
            // TODO : review için url
            else {
              final url = "kareagency.com/reff";
              if (await canLaunch(url)) {
                launch(url);
              }
            }
          },
          title: Text('Uygulamayı Değerlendir')),
      ListTile(
          dense: true,
          leading: Icon(MdiIcons.mail),
          onTap: () async {
            // TODO : mail taslağı
            final email = Email(
              body: "body",
              subject: "subject",
              recipients: ["info@kareagency.com"],
            );
            await FlutterEmailSender.send(email);
          },
          title: Text('Mail')),
      ListTile(
          dense: true,
          leading: Icon(MdiIcons.earth),
          onTap: () async {
            // TODO : website url
            const url = "kareagency.com";
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
          title: Text('Website'))
    ];

class AboutMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
