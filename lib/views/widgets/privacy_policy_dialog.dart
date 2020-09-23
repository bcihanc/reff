import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PrivacyPolicyDialog extends HookWidget {
  const PrivacyPolicyDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Kare Agency Gizlilik Sözleşmesi'),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Text("""
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
 Ipsum has been the industry's standard dummy text ever since the 1500s, when an
  unknown printer took a galley of type and scrambled it to make a type specimen
   book. It has survived not only five centuries, but also the leap into 
   electronic typesetting, remaining essentially unchanged. It was popularised 
   in the 1960s with the release of Letraset sheets containing Lorem Ipsum 
   passages, and more recently with desktop publishing software like Aldus 
   PageMaker including versions of Lorem Ipsum, Lorem Ipsum is simply dummy 
   text of the printing and typesetting industry. Lorem Ipsum has been the 
   industry's standard dummy text ever since the 1500s, when an unknown printer 
   took a galley of type and scrambled it to make a type specimen book. It has 
   survived not only five centuries, but also the leap into electronic 
   typesetting, remaining essentially unchanged. It was popularised in the 
   1960s with the release of Letraset sheets containing Lorem Ipsum passages, 
   and more recently with desktop publishing software like Aldus PageMaker 
   including versions of Lorem Ipsum"""),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            child: RaisedButton.icon(
                color: Theme.of(context).accentColor,
                icon: Icon(MdiIcons.close),
                label: Text('Kapat'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ]),
      ),
    );
  }
}
