library array;

// extension F on Object {
//   int operator >>>(int n) {
//     var temParse = double.tryParse(toString());
//     int temp = temParse is int || temParse is double ? (temParse!.toInt() >>> n) : 0;
//     return temp;
//   }
// }
extension L on List {

  /// 
  /// Returns a new list
  /// 
  /// ```dart
  /// List list = [1, [2, [3, { 'name': [123] }]]];
  /// print(list.flat(1)); // [1, 2, [3, {name: [123]}]]
  /// ```
  ///
  /// If [depth] is null, it defaults to the [1] of this list.
  ///
  /// ```dart
  /// List list = [1, [2, [3, { 'name': [123] }]]];
  /// print(list.flat()); // [1, 2, [3, {name: [123]}]]
  /// ```
  ///
  /// If you confusion this list length, you fully can set as [double.infinity]
  /// List list = [1, [2, [3, { 'name': [123] }]]];
  /// print(list.flat(double.infinity)); // [1, 2, 3, {name: [123]}]
  List flat([double? depth = 1]) {
    List result = [];

    flatDeep(arr, depth) {
      arr.forEach((val) {
        if (depth > 0 && val is List) {
          flatDeep(val, depth - 1);
        } else {
          result.add(val);
        }
      });
    }
    if (depth != null && depth < 0 || isEmpty) return this;

    flatDeep(this, depth ?? 1);
    return result;
  }

  /// 
  /// Returns a new list
  /// 
  /// It's different from flat, it just flat[depth] for 1.
  /// 
  /// ```dart
  /// List list = [{ 'name': 123, 'age': 0 }, { 'name': 124, 'age': 1 }];
  /// List res = list.flatMap((e) {
  ///  print(e);
  ///  return e['name'];
  /// });
  /// 
  /// print(res);  // [123, 124]
  /// ```
  List flatMap(fn) {
    return map(fn).toList().flat(1);
  }

  /// 
  /// Returns a new list
  /// 
  /// ```dart
  /// List list = [{ 'name': 123, 'age': 0 }, { 'name': 124, 'age': 1 }];
  /// List res = list.filter((item, index, list) {
  ///  print(item); // it's current item
  ///  print(index); // it's current index
  ///  print(list); // it's source list
  ///  return item['name'];
  /// });
  /// 
  /// print(res);  // [{name: 123, age: 0}]
  /// ```
  List filter(Function fun) {
    if (isEmpty) return this;

    List t = this;
    int len = t.length >>> 0;

    List res = [];
    for (var i = 0; i < len; i++) {
      var val = t[i];
      try {
        if (fun(val, i, t)) {
          res.add(val);
        }
      } catch (e) {
        throw ArgumentError.value('current introduced Function not return a bool type');
      }
    }

    return res;
  }

  /// 
  /// One can like JavaScript without reduce
  /// 
  /// ```dart
  /// List list = [{ 'name': 123, 'age': 0 }, { 'name': 124, 'age': 1 }];
  /// 
  /// var res = list.reducex((returnValue, currentValue, index, sourceList) {
  ///   returnValue.add({
  ///     'currentKey': currentValue['name']
  ///   });
  ///   return returnValue;
  /// }, []);
  /// 
  /// print(res);  // [{currentKey: 123}, {currentKey: 124}]
  /// ```
  reducex(Function callback, [defaultValue]) {

    List o = this;

    int len = o.length >>> 0;

    int k = 0;
    var value;

    if (defaultValue != null) {
      value = defaultValue;
    } else {
      value = o[k];
    }

    while (k < len) {
      if (k < o.length) {
        value = callback(value, o[k], k, o);
      }

      k++;
    }

    return value;
  }
  /// 
  /// Returns a new list
  /// 
  /// ```dart
  /// List list1 = ['foo', 'bar', 'baz', 'qux'];
  /// List list2 = ['foo', 'qux'];
  /// 
  /// print(list1 - list2);  // bar, baz
  /// ```
  List operator -(List arr) {
    return where((element) => !arr.contains(element)).toList();
  }

  /// 
  /// Returns a new list
  /// 
  /// ```dart
  /// List list = [0];
  /// List list1 = [{ 'name': 444, 'age': 0 }, { 'name': 124, 'age': 1 }];
  /// 
  /// print(list + list1);  // [0, {name: 444, age: 0}, {name: 124, age: 1}]
  /// ```
  List operator +(List arr) {
    addAll(arr);
    return arr;
  }

  /// 
  /// Returns a new list
  /// 
  /// ```dart
  /// List list = List list = [1,null, 2, '12.3'];
  /// 
  /// print(list * 3);  // [3.0, 0.0, 6.0, 36.900000000000006]
  /// ```
  List operator *(double number) {
    // return map((item) => (item >>> 0) * number).toList();
    return map((item) => (double.tryParse(item.toString()) ?? 0) * number).toList();
  }
}
