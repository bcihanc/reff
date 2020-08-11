import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/utils/constants.dart';

class GenderSelector extends StatefulHookWidget {
  final ValueChanged<Gender> onChanged;

  GenderSelector({this.onChanged});

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  @override
  Widget build(BuildContext context) {
    final gendersState = useState([
      GenderWidgetModel(
          name: "Erkek",
          icon: MdiIcons.genderMale,
          isSelected: true,
          gender: Gender.MALE),
      GenderWidgetModel(
          name: "Kadın",
          icon: MdiIcons.genderFemale,
          isSelected: false,
          gender: Gender.FEMALE),
      GenderWidgetModel(
          name: "Diğer",
          icon: MdiIcons.genderTransgender,
          isSelected: false,
          gender: Gender.OTHERS)
    ]);

    return Container(
      alignment: Alignment.center,
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: gendersState.value.length,
          itemBuilder: (context, index) {
            return InkWell(
              key: KeysForTesting.gendersKey[index],
              splashColor: Theme.of(context).accentColor,
              onTap: () {
                gendersState.value
                    .forEach((gender) => gender.isSelected = false);
                gendersState.value[index].isSelected = true;
                setState(() {});
                widget.onChanged(gendersState.value[index].gender);
              },
              child: CustomRadio(gender: gendersState.value[index]),
            );
          }),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final GenderWidgetModel gender;

  CustomRadio({this.gender});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: gender.isSelected
            ? Theme.of(context).accentColor.withOpacity(0.5)
            : Colors.transparent,
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          margin: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                gender.icon,
                color: gender.isSelected ? Colors.white : Colors.grey,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                gender.name,
                style: TextStyle(
                    color: gender.isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
        ));
  }
}

class GenderWidgetModel {
  String name;
  IconData icon;
  bool isSelected;
  Gender gender;

  GenderWidgetModel({this.name, this.icon, this.isSelected, this.gender});
}
