import 'dart:ui';

import 'package:deus_mobile/screens/wallet_intro_screen/widgets/form/seed_phrase_grid.dart';
import 'package:deus_mobile/statics/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'form/paper_form.dart';
import 'form/paper_input.dart';
import 'form/paper_validation_summary.dart';
import '../../../core/widgets/grey_outline_button.dart';
import '../../../core/widgets/raised_gradient_button.dart';

class ConfirmMnemonic extends HookWidget {
  ConfirmMnemonic(
      {this.mnemonic, this.errors, this.onConfirm, this.onGenerateNew});

  final String mnemonic;
  final List<String> errors;
  final Function onConfirm;
  final Function onGenerateNew;

  final darkGrey = Color(0xFF1C1C1C);
  final LinearGradient button_gradient =
      LinearGradient(colors: [Color(0xFF0779E4), Color(0xFF1DD3BD)]);

  List<String> shownWords = [];

  List<String> _testList = [
    'sa',
    'asdf',
    'oqu',
    'asöjdnb',
    'cyvxcv',
    'qwe',
    'pqiwe'
  ];


  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width - 60;
//letter = 10px
// edges = 60px

    var mnemonicController = useTextEditingController();
    return Stack(
      children: [
        _buildHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 5),
                child: Text(
                  'Seed Phrase',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              _buildConfirmContainer(mnemonicController, context),
            ],
          ),
        )
      ],
    );
  }


  Widget _buildConfirmContainer(TextEditingController mnemonicController, BuildContext context) {
    return PaperForm(
      padding: 0,
      actionButtons: <Widget>[
        GreyOutlineButton(label: 'BACK', onPressed: this.onGenerateNew),
        SizedBox(width: 10),
        RaisedGradientButton(
          gradient: button_gradient,
          label: 'CONFIRM',
          onPressed: this.onConfirm != null
              ? () => this.onConfirm(mnemonicController.value.text)
              : null,
        ),
      ],
      children: <Widget>[
        PaperValidationSummary(this.errors),
        SeedPhraseGrid(
          wordList: _testList,
          context: context,
        )
        //_buildConfirmTextField(mnemonicController),
      ],
    );
  }



  Container _buildConfirmTextField(TextEditingController mnemonicController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: darkGrey,
      ),
      child: PaperInput(
        textStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        hintText: 'Confirm your seed',
        maxLines: 2,
        controller: mnemonicController,
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            'Please confirm your Seed Phrase',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
