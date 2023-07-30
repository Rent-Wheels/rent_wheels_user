import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';

import '../../../../core/widgets/buttons/generic_button_widget.dart';
import '../../../../core/widgets/textStyles/text_styles.dart';

class HorizontalScroll extends StatelessWidget {
  const HorizontalScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children:  [
            for(String section in sections)
              HorizontalScrollButton(label: section)
          ],
        ));
  }
}

class HorizontalScrollButton extends StatefulWidget {
  final String label;
  const HorizontalScrollButton({super.key, required this.label});

  @override
  State<HorizontalScrollButton> createState() => _HorizontalScrollButtonState();
}

class _HorizontalScrollButtonState extends State<HorizontalScrollButton> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        onPressed: (){},
        // style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(1))),
        child: Text(widget.label, style: heading6Brand,),
      ),
    );
  }
}



List<String> sections = ['All', 'Ongoing', 'Completed', 'Cancelled', 'Dummy one', 'Dummy two'];