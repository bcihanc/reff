import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/utils/constants.dart';

class GenderSelector extends StatefulHookWidget {
  final ValueChanged<Gender> onChanged;
  final Gender initial;

  GenderSelector({@required this.initial, this.onChanged})
      : assert(initial != null);

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
      height: 50,
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

class EducationSelectorWidget extends StatefulHookWidget {
  final Education initial;
  final ValueChanged<Education> onChanged;

  EducationSelectorWidget({@required this.initial, this.onChanged})
      : assert(initial != null);

  @override
  _EducationSelectorWidgetState createState() =>
      _EducationSelectorWidgetState();
}

class _EducationSelectorWidgetState extends State<EducationSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final educationState = useState(widget.initial);

    return DropdownButton<Education>(
      value: educationState.value,
      underline: SizedBox.shrink(),
      items: Education.values
          .map((education) =>
          DropdownMenuItem<Education>(
            value: education,
            child: Text(tr(education.toString())),
          ))
          .toList(),
      onChanged: (education) {
        widget.onChanged(education);
        educationState.value = education;
      },
    );
  }
}
