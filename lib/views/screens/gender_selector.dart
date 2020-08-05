import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GenderSelector extends StatefulWidget {
  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  final genders = [
    GenderWidgetModel("Male", MdiIcons.genderMale, false),
    GenderWidgetModel("Female", MdiIcons.genderFemale, false),
    GenderWidgetModel("Others", MdiIcons.genderTransgender, false)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: genders.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.pinkAccent,
              onTap: () {
                setState(() {
                  genders.forEach((gender) => gender.isSelected = false);
                  genders[index].isSelected = true;
                });
              },
              child: CustomRadio(gender: genders[index]),
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
        color: gender.isSelected ? Color(0xFF3B4257) : Colors.white,
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          margin: new EdgeInsets.all(5.0),
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

  GenderWidgetModel(this.name, this.icon, this.isSelected);
}
