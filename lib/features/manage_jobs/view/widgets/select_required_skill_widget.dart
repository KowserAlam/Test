import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/models/skill.dart';
import 'package:jobxprss_company/main_app/repositories/skill_list_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_auto_complete_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_wrap.dart';

class SelectRequiredSkillWidget extends StatefulWidget {
  final Function(Skill skill) onSuggestionSelected;
  final List<Skill> items;

  SelectRequiredSkillWidget({
    @required this.onSuggestionSelected,
    @required this.items,
  });

  @override
  _SelectRequiredSkillWidgetState createState() =>
      _SelectRequiredSkillWidgetState();
}

class _SelectRequiredSkillWidgetState extends State<SelectRequiredSkillWidget> {
  List<Skill> skillList = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      SkillListRepository().getSkillList().then((value) {
        value.fold((l) => [], (r) {
          skillList = r;
          setState(() {});
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomWrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 14,
          column: 8,
          symmetry: false,
          textDirection: TextDirection.ltr,
          direction: Axis.horizontal,
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: List.generate(widget.items.length, (index) {
            var item = widget.items[index];
            return Material(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8,top: 4,bottom: 4),
              child: Text(item.name),

            ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8,left: 8,top: 4,bottom: 4),
                        child: Icon(Icons.clear,size: 20,color: Colors.red,),
                      ),
                    )
                  ],
                ));
          }),
        ),
        CustomAutoCompleteTextField<Skill>(
          labelText: StringResources.requiredSkills,
          suggestionsCallback: (String pattern) async {

            return skillList
                .where((element) =>
                    element.name.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          onSuggestionSelected: (v){
            if(widget.onSuggestionSelected != null)
            widget.onSuggestionSelected(v);
            setState(() {

            });
          },
          itemBuilder: (BuildContext context, itemData) {
            return ListTile(
              title: Text(itemData.name),
            );
          },
        ),
      ],
    );
  }
}
