/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2020-2021. All rights reserved.
 */

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String _text;
  final VoidCallback _onPressed;

  const CustomButton(this._text, this._onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(),
      onPressed: _onPressed,
      // color: Colors.blueGrey,
      // textColor: Colors.white,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      // splashColor: Colors.blueAccent,
      child: Text(_text, style: const TextStyle(fontSize: 14)),
    );
  }
}
