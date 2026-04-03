import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../exceptions/app_exception.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BaseViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Future<T?> runSafely<T>(AsyncValueGetter<T> action) async {
    try {
      return await action.call();
    } on AppException catch (e, s) {
      log(e.message, stackTrace: s);
      handleError(e.message);
      return null;
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      handleError('Something went wrong');
      return null;
    }
  }

  @mustCallSuper
  void init() {
    log('INITIALIZING $runtimeType', name: 'RIVERPOD');
  }

  @mustCallSuper
  @override
  void dispose() {
    log('DISPOSING $runtimeType', name: 'RIVERPOD');
    super.dispose();
  }

  @mustCallSuper
  void handleError(String message) {
    EasyLoading.showError(message);
  }
}
