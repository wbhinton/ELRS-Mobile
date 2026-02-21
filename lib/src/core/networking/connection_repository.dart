// Copyright (C) 2026  Weston Hinton [wbhinton@gmail.com]
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_repository.g.dart';

@Riverpod(keepAlive: true)
class TargetIp extends _$TargetIp {
  @override
  String? build() {
    return null;
  }

  void updateIp(String newIp) {
    if (state != newIp) {
      print('CONNECTION: Target IP updated to $newIp');
      state = newIp;
    }
  }
}
