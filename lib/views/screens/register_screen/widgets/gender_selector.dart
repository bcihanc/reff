import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/utils/constants.dart';

class GenderPicker extends StatefulHookWidget {
  const GenderPicker();

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderPicker> {
  @override
  Widget build(BuildContext context) {
    final gendersState = useState([
      GenderSelectorWidgetModel(
          name: tr("Man"),
          icon: MdiIcons.genderMale,
          isSelected: true,
          gender: Gender.MALE),
      GenderSelectorWidgetModel(
          name: tr("Woman"),
          icon: MdiIcons.genderFemale,
          isSelected: false,
          gender: Gender.FEMALE),
      GenderSelectorWidgetModel(
          name: tr("Others"),
          icon: MdiIcons.genderTransgender,
          isSelected: false,
          gender: Gender.OTHERS)
    ]);

    return Container(
      alignment: Alignment.center,
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: gendersState.value.length,
          itemBuilder: (context, index) {
            return InkWell(
              key: KeysForTesting.gendersKey[index],
              splashColor: Colors.transparent,
              onTap: () {
                for (final gender in gendersState.value) {
                  gender.isSelected = false;
                }

                gendersState.value[index].isSelected = true;
                setState(() {});
                context
                    .read(UserState.provider)
                    .setGender(gendersState.value[index].gender);
              },
              child: CustomRadio(gender: gendersState.value[index]),
            );
          }),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final GenderSelectorWidgetModel gender;

  const CustomRadio({@required this.gender}) : assert(gender != null);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        color: gender.isSelected
            ? Theme.of(context).accentColor
            : Theme.of(context).cardColor,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                gender.icon,
                color: gender.isSelected ? Colors.white : Colors.grey,
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  gender.name,
                  style: TextStyle(
                      color: gender.isSelected ? Colors.white : Colors.grey),
                ),
              )
            ],
          ),
        ));
  }
}

class GenderSelectorWidgetModel {
  String name;
  IconData icon;
  bool isSelected;
  Gender gender;

  GenderSelectorWidgetModel(
      {this.name, this.icon, this.isSelected, this.gender});
}
