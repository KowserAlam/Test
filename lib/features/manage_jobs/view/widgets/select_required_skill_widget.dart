import 'package:dartz/dartz.dart' as dartZ;
import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/models/skill.dart';
import 'package:jobxprss_company/main_app/repositories/skill_list_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_auto_complete_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_wrap.dart';

class SelectRequiredSkillWidget extends StatefulWidget {
  final Function(Skill skill) onSuggestionSelected;
  final Function(int index) onRemove;
  final List<Skill> items;


  SelectRequiredSkillWidget({
    @required this.onSuggestionSelected,
    @required this.items,
    this.onRemove,

  });

  @override
  _SelectRequiredSkillWidgetState createState() =>
      _SelectRequiredSkillWidgetState();
}

class _SelectRequiredSkillWidgetState extends State<SelectRequiredSkillWidget> {
  List<Skill>skillList=[];
  final controller = TextEditingController();

  @override
  void initState() {
    SkillListRepository()
        .getSkillList()
        .then((v) => v.fold((l) => [], (r) {
      setState(() {

      });
      skillList = r;
    }));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        CustomAutoCompleteTextField<Skill>(
          controller: controller,
          labelText: StringResources.requiredSkillsText,
          hintText: StringResources.requiredSkillsText,
          suggestionsCallback: (String pattern)async {
            var list = skillList
                .where((element) => element?.name
                ?.toLowerCase()
                ?.contains(pattern.toLowerCase()))
                .toList();
            // print(list);
            return list;
          },
          onSuggestionSelected: (v) {
            if (widget.onSuggestionSelected != null) {
              if (!widget.items.contains(v))
                widget.onSuggestionSelected(v);
              controller.clear();
              setState(() {});
            }
          },
          itemBuilder: (BuildContext context, itemData) {
            return Material(
              color: widget?.items?.contains(itemData) ?? false
                  ? primaryColor
                  : Colors.transparent,
              child: ListTile(
                title: Text(itemData.name),
              ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
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
                      padding:
                          const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                      child: Text(item.name),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (widget.onRemove != null) {
                          widget.onRemove(index);
                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, top: 4, bottom: 4),
                        child: Icon(
                          Icons.clear,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ));
          }),
        ),
      ],
    );
  }
}
