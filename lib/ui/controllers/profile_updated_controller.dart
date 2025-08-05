import 'dart:core';

import 'package:get/get.dart';
import 'package:np/data/model/add_new_task_model.dart';

import '../../data/model/profile_updated_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';


class ProfileUpdatedController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late String _message;
  String get message => _message;

  Future<bool> updatedProfile(ProfileUpdated model) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.postReqest(
        url: Urls.profileUpdatedUrl, body: model.toJson());
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
