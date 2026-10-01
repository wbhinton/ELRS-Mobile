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

import 'package:dio/dio.dart';

/// Returns `true` when a [DioException] represents the hardware violently
/// severing the connection after receiving a reboot/update command.
///
/// These errors map to errno values such as:
/// - 103 — ECONNABORTED  (Software caused connection abort)
/// - 104 — ECONNRESET    (Connection reset by peer)
/// - 32  — EPIPE         (Broken pipe)
/// - 111 — ECONNREFUSED  (Connection refused — device already down)
bool isExpectedRebootSocketDrop(DioException e) {
  final description = e.toString().toLowerCase();
  const expectedFragments = [
    'software caused connection abort',
    'connection closed before full header was received',
    'connection reset by peer',
    'broken pipe',
    'connection refused',
  ];
  return expectedFragments.any(description.contains);
}
