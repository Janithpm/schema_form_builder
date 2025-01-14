import 'dart:io';

import 'package:flutter/material.dart';

class MultiPageFormController {

  MultiPageFormController({required this.totalPages}) {
    generateFormKeys(totalPages);
    currentPageNotifier.addListener(() {
      validateMainActionState();
    });
  }

  int totalPages = 0;
  final PageController pageController = PageController();
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool> isMainActionDisabledNotifier = ValueNotifier<bool>(true);
  List<GlobalKey<FormState>> formKeys = [];

  final Map<String, dynamic> _formData = {};

  int get currentPage => currentPageNotifier.value;
  bool get isMainActionDisabled => isMainActionDisabledNotifier.value;

  void generateFormKeys(int totalPages) {
    formKeys = List.generate(totalPages, (_) => GlobalKey<FormState>());
  }

  void onPageChanged(int page) {
    currentPageNotifier.value = page;
    validateMainActionState();
  }

  void onFormChanged() {
    validateMainActionState();
  }

  void goToNextPage() {
    if (validateCurrentPage()) {
      saveCurrentPageData();
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPreviousPage() {
    saveCurrentPageData();
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void handleMainAction(Function(Map<String, dynamic>) onSubmit) {
    if (currentPageNotifier.value < totalPages - 1) {
      goToNextPage();
    } else {
      if (validateAllPages()) {
       saveCurrentPageData();
       onSubmit(getAllData());
      }
    }
  }

  bool validateCurrentPage() {
    return formKeys[currentPageNotifier.value].currentState?.validate() ?? false;
  }

  bool validateAllPages() {
    for (var key in formKeys) {
      if (key.currentState?.validate() == false) {
        return false;
      }
    }
    return true;
  }

  void validateMainActionState () {
    if(validateCurrentPage()) {
      isMainActionDisabledNotifier.value = false;
    } else {
      isMainActionDisabledNotifier.value = true;
    }
  }

  void saveCurrentPageData() {
    formKeys[currentPageNotifier.value].currentState?.save();
  }

  void setData(String key, dynamic value) {
    _formData[key] = value;
  }

  void removeData(String key) {
    _formData.remove(key);
  }

  File? getImage(String key) {
    //for easy testing return File(_formData[key]?.path ?? '');
    final xFile = _formData[key];
    if (xFile == null){
      return null;
    }
    return File(xFile.path);
  }

  File getXImage(String key) => _formData[key];

  void onImageSelect(String key, File? image) async {
    if (image == null) {
      removeData(key);
    } else  {
      setData(key, image);
    }
  }

  void onSelect(String key, dynamic value) {
    setData(key, value);
  }

  dynamic getData(String key) {
    return _formData[key];
  }

  Map<String, dynamic> getAllData() {
    return Map.from(_formData);
  }

  void clearData() {
    _formData.clear();
  }
}
