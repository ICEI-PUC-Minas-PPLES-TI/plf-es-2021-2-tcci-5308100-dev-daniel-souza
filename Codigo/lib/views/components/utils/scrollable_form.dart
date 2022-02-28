import 'package:flutter/cupertino.dart';

class ScrollableForm extends Form {
  ScrollableForm({
    Key? key,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    required List<Widget> children,
  }) : super(
          key: key,
          autovalidateMode: autovalidateMode,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        );
}
