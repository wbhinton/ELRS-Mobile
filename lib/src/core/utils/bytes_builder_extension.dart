// Copyright (C) 2026  Weston Hinton [wbhinton@gmail.com]
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

import 'dart:typed_data';

extension BytesBuilderExtension on BytesBuilder {
  void addWord(int value, [Endian endian = Endian.big]) {
    final bytes = Uint8List(2);
    ByteData.view(bytes.buffer).setUint16(0, value, endian);
    add(bytes);
  }

  void addDWord(int value, [Endian endian = Endian.big]) {
    final bytes = Uint8List(4);
    ByteData.view(bytes.buffer).setUint32(0, value, endian);
    add(bytes);
  }

  void addWords(Iterable<int> values, [Endian endian = Endian.big]) {
    for (final value in values) {
      addWord(value, endian);
    }
  }
}
