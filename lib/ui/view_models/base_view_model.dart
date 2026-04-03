import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../exceptions/app_exception.dart';

abstract class BaseViewModel<S> extends Notifier<S> {
  final S initialState;
  BaseViewModel(this.initialState);

  @override
  S build() {
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
    ref.onDispose(dispose);
    return initialState;
  }

  Future<T?> runSafely<T>(AsyncValueGetter<T> action) async {
    try {
      return await action.call();
    } on AppException catch (e, s) {
      log(e.message, stackTrace: s);
      handleError(e.message);
      return null;
    } on DioException catch (e, s) {
      log(e.message ?? 'Something went wrong', stackTrace: s);
      handleError(e.message ?? 'Something went wrong');
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
  void dispose() {
    log('DISPOSING $runtimeType', name: 'RIVERPOD');
  }

  @mustCallSuper
  void handleError(String message) {
    EasyLoading.showError(message);
  }
}
