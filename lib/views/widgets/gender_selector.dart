import 'package:easy_localization/easy_localization.dart';
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
                for (final gender in gendersState.value) {
                  gender.isSelected = false;
                }

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
  final GenderSelectorWidgetModel gender;

  CustomRadio({this.gender});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        color: gender.isSelected
            ? Theme.of(context).accentColor.withOpacity(0.5)
            : Theme.of(context).cardColor,
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
                color: gender.isSelected ? Colors.white : Colors.black,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                gender.name,
                style: TextStyle(
                    color: gender.isSelected ? Colors.white : Colors.black),
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

class EducationSelectorWidget extends StatefulHookWidget {
  final ValueChanged<Education> onChanged;

  EducationSelectorWidget({this.onChanged});

  @override
  _EducationSelectorWidgetState createState() =>
      _EducationSelectorWidgetState();
}

class _EducationSelectorWidgetState extends State<EducationSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final educationState = useState(Education.BACHELOR);

    return Column(
      children: [
        Icon(MdiIcons.license),
        DropdownButton<Education>(
          value: educationState.value,
          items: Education.values.map((education) {
            return DropdownMenuItem<Education>(
              value: education,
              child: Text(tr(education.toString())),
            );
          }).toList(),
          onChanged: (education) {
            widget.onChanged(education);
            educationState.value = education;
          },
        ),
      ],
    );
  }
}
