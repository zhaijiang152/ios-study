# map运算符

在iOS开发中，`map`运算符是Swift标准库提供的高阶函数，主要用于对集合类型（如Array、Dictionary等）中的每个元素进行转换操作

### 一、运算原理

1. **函数式转换**
   `map`会遍历集合中的每个元素，通过闭包函数进行转换，最终返回包含所有转换结果的新数组。其底层实现可简化为：

   swift

   ```swift
   @inlinable public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
       var result = [T]()
       for element in self {
           result.append(try transform(element))
       }
       return result
   }
   ```

   

2. **惰性求值优化**
   实际执行时Swift会通过编译器优化（如`@inlinable`）将闭包内联，减少函数调用开销

### 二、使用示例

1. **基础转换**

   ```swift
   let numbers = [1, 2, 3]
   let squared = numbers.map { $0 * $0 }  // [1, 4, 9]
   ```

2. **类型转换**

   ```swift
   struct Person {
     var name: String
   }
   let people = [Person(name: "Alice"), Person(name: "Bob")]
   let names = people.map(\.name)  // ["Alice", "Bob"] 
   ```

3. **字典处理**

   ```swift
   let dict = ["A": 1, "B": 2]
   let descriptions = dict.map { "\($0.key):\($0.value)" }  // ["A:1", "B:2"]
   ```