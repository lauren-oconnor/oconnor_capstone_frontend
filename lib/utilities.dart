import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widgets/recyclable.dart';
import 'utilities.dart';

OutlineInputBorder inputFormDeco() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide:
    const BorderSide(
        width: 1.0,
        color: Colors.lightGreen,
        style: BorderStyle.solid),
  );
}


Future<void> savingData(formKey) async {
  final validation = formKey.currentState?.validate();
  if (!validation!) {
    return;
  }
  formKey.currentState!.save();
}