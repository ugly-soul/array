# array
用于flutter使用的数组拓展方法 (List extension function)

之后会拓展出更多的方法！

## 添加依赖
```javascript
  dependencies:
    array: ^0.0.1
```

## List.flat
```javascript
  import 'package:array/array.dart';

  // 数组扁平化
  List list = [1, [2, [3, { 'name': [123] }]]];
  print(list.flat(1)); // [1, 2, [3, {name: [123]}]]
  print(list.flat()); // 默认是展开1层， [1, 2, [3, {name: [123]}]]

  // 如果你不知道数组的深度，你可以传入double.infinity：
  print(list.flat(double.infinity)); // [1, 2, 3, {name: [123]}]

```

## List.flatMap
```javascript
  import 'package:array/array.dart';

  // 数组扁平化
  // 它和flat不一样的是，它只会展开一层，而且接收一个方法，用于映射出对应的值
  List list = [{ 'name': 123, 'age': 0 }, { 'name': 124, 'age': 1 }];
  List res = list.flatMap((e) {
   print(e);
   return e['name'];
  });
  
  print(res);  // [123, 124]

```

## List.filter
```javascript
  import 'package:array/array.dart';

  // 数组过滤，和js一样
  List list = [{ 'name': 123, 'age': 0 }, { 'name': 124, 'age': 1 }];
  List res = list.filter((item, index, list) {
   return item['name'];
  });
  
  print(res);  // [{name: 123, age: 0}]

```

## List.reducex
```javascript
  import 'package:array/array.dart';

  // 数组过滤，和js一样
  List list = [{ 'name': 123, 'age': 0 }, { 'name': 124, 'age': 1 }];
  var res = list.reducex((returnValue, currentValue, index, sourceList) {
    returnValue.add({
      'currentKey': currentValue['name']
    });
    return returnValue;
  }, []);
  
  print(res);  // [{currentKey: 123}, {currentKey: 124}]

```
