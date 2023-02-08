import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/repo/repo.dart';
import 'package:wurigiri/widget/w_loading.dart';

abstract class Controller<T extends Repo> extends GetxController {
  Controller(this.repo);
  final T repo;
  bool _inited = false;

  bool get isInited => _inited;
  @mustCallSuper
  Future init() async {
    if (_inited) {
      return;
    }
    await repo.init();
    _inited = true;
  }

  static Future put<T extends Controller>(T controller) async {
    await controller.init();
    Get.put(controller);
  }

  void loadingOverlay({
    required Future<bool> Function() asyncFunction,
  }) {
    Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: const WLoading(),
    );
  }
}
