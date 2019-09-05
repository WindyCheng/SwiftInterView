import UIKit
/*
一、open与public的区别

public：可以别任何人访问，但是不可以被其他module复写和继承。
open：可以被任何人访问，可以被继承和复写。

二、struct与class 的区别

struct是值类型，class是引用类型。
值类型的变量直接包含它们的数据，对于值类型都有它们自己的数据副本，因此对一个变量操作不可能影响另一个变量。
引用类型的变量存储对他们的数据引用，因此后者称为对象，因此对一个变量操作可能影响另一个变量所引用的对象。
二者的本质区别：struct是深拷贝，拷贝的是内容；class是浅拷贝，拷贝的是指针。
property的初始化不同：class 在初始化时不能直接把 property 放在 默认的constructor 的参数里，而是需要自己创建一个带参数的constructor；而struct可以，把属性放在默认的constructor 的参数里。
变量赋值方式不同：struct是值拷贝；class是引用拷贝。
immutable变量：swift的可变内容和不可变内容用var和let来甄别，如果初始为let的变量再去修改会发生编译错误。struct遵循这一特性；class不存在这样的问题。
mutating function： struct 和 class 的差別是 struct 的 function 要去改变 property 的值的时候要加上 mutating，而 class 不用。
继承： struct不可以继承，class可以继承。
struct比class更轻量：struct分配在栈中，class分配在堆中。

三、swift把struct作为数据模型
3.1优点

安全性： 因为 Struct 是用值类型传递的，它们没有引用计数。
内存： 由于他们没有引用数，他们不会因为循环引用导致内存泄漏。
速度： 值类型通常来说是以栈的形式分配的，而不是用堆。因此他们比 Class 要快很多!
拷贝：Objective-C 里拷贝一个对象,你必须选用正确的拷贝类型（深拷贝、浅拷贝）,而值类型的拷贝则非常轻松！
线程安全： 值类型是自动线程安全的。无论你从哪个线程去访问你的 Struct ，都非常简单。

3.2 缺点

Objective-C与swift混合开发：OC调用的swift代码必须继承于NSObject。
继承：struct不能相互继承。
NSUserDefaults：Struct 不能被序列化成 NSData 对象
 */

//1.交换两个元素
func swap<T>(_ nums: inout [T], _ p: Int, _ q: Int) {
    (nums[p], nums[q]) = (nums[q], nums[p])
}

var arr = [4,3]
swap(&arr, 1, 0)

//2. 实现一个函数，输入是任一整数，输出要返回输入的整数 + 2
func add(_ num: Int) -> (Int) -> Int {
    return { val in
        return num + val
    }
}

let addTwo = add(2)
let addFour = add(4)
let addSix = add(6)
let addEight = add(8)

//3. 精简以下代码
func divide(dividend: Double?, by divisor: Double?) -> Double? {
    if dividend == nil {
        return nil
    }
    if divisor == nil {
        return nil
    }
    if divisor == 0 {
        return nil
    }
    return dividend! / divisor!
}

func divide1(dividend: Double?, by divisor: Double?) -> Double? {
    guard let dividend = dividend, let divisor = divisor, divisor != 0 else {
        return nil
    }
    
    return dividend / divisor
}

//4. 以下函数会打印出什么？
var car = "Benz"
let closure = { [car] in
    print("I drive \(car)")
}
car = "Tesla"
closure()

var car1 = "Benz"
let closure1 = {
    print("I drive \(car1)")
}
car1 = "Tesla"
closure1()

//7. Swift 中 struct 和 class 什么区别？举个应用中的实例
class A {
    var val = 1
}

var a = A()
var b = a
b.val = 2
a.val
//此时 a 的 val 也被改成了 2，因为 a 和 b 都是引用类型，本质上它们指向同一内存


struct A1 {
    var val = 1
}

var a1 = A1()
var b1 = a1
b1.val = 2
a1.val
//此时 A 是struct，值类型，b 和 a 是不同的东西，改变 b 对于 a 没有影响。


//8. Swift 到底是面向对象还是函数式的编程语言？
/*
Swift 既是面向对象的，又是函数式的编程语言。
说 Swift 是 Object-oriented，是因为 Swift 支持类的封装、继承、和多态，从这点上来看与 Java 这类纯面向对象的语言几乎毫无差别。
说 Swift 是函数式编程语言，是因为 Swift 支持 map, reduce, filter, flatmap 这类去除中间状态、数学函数式的方法，更加强调运算结果而不是中间过程。*/

/*
 网上已经有很多针对各种知识点的面试题，面试时有些人未必真正理解也能通过背题看上去很懂。我自己总结了4道面试题，好快速的判断这个人是否是一个合格的工程师，欢迎大家点评。
 1.struct和class的区别
 
 在面试之前你觉得所有的计算机专业的学生都应该能答的上来，事实是我面的人里有超过三分一没有答上来。
 有时我还会顺便问下swift里的array是什么类型，在大量复制时会不会有性能问题。
 2.介绍一下观察者模式
 
 也许有些人已经觉得设计模式有些过时，没有整本读过。就算如此iOS里常用的几个设计模式我觉得总要了解吧。
 这里如果说NSNotificationCenter怎么使用的就直接pass。
 这个回答应该包括三个部分：首先这个设计模式为了解决什么问题，其次通过什么方案来解决，最后才是当前体系下的具体实现方案。
 3.在一个https连接的网站里，输入账号密码点击登录后，到服务器返回这个请求前，中间经历了什么
 
 这题是在其他看到的，本来题目是登录gmail的时候，但是国内也许有些人不知道Google很早就全站https了，所以这里特别指出是https的连接。
 这里面可以谈的东西就很多了，TCP/IP下有非常多的协议。不需要什么都能说的清楚，但是对于整个网络连接模型的理解可以看出基本功。
 4.在一个app中间有一个button，在你手触摸屏幕点击后，到这个button收到点击事件，中间发生了什么
 
 runloop和响应链需要说的清楚。
 有时还会顺便问问UIResponder、UIControl、UIView的关系。
 
 这4个问题只是为了一上来可以快速筛选掉不合适的程序员，毕竟有的人只需要几分钟就知道他不合适了，好节省时间。
 
 中午吃饭我和一个资深的同事说这些题目，我说，一个15k+的程序员我觉得一定能答的上这四题。他说你也太乐观了，按现在这行情他觉得恐怕要20k的程序员才能答的上来。 */

var mutableArray = [1,2,3]
for _ in mutableArray {
    mutableArray.removeLast()
}

mutableArray

let someString = "123"
let someNSString = NSString(string: "n123")
let strintToNSString = someString as NSString
let nsstringToString = someNSString as String



func divided(dividend: Double?, by divisor: Double?) -> Double? {
    guard let dividend = dividend, let divisor = divisor, divisor != 0 else {
        return .none
    }
    return dividend / divisor
}

infix operator ^^
func ^^(lhs: Int, rhs: Int) -> Int {
    let l = Double(lhs)
    let r = Double(rhs)
    let p = pow(l, r)
    return Int(p)
}

let v = 4^^5

//泛型解决了代码重复的问题。 一个常见的情况是当你有一个方法接受一种类型的参数，你必须复制它只是为了适应另一个类型的参数。
/*使用隐式解包可选的最常见原因是：

当不是自然的nil属性不能在实例化时初始化。 一个典型的例子是Interface Builder插件，它在所有者初始化后总是初始化。 在这种特定情况下 - 假设它在Interface Builder中正确配置 - 插座在使用之前保证为非零。

解决强参考周期问题，这是两个实例彼此引用并且需要对其他实例的非空参考。 在这种情况下，引用的一侧可以标记为未知，而另一侧使用隐式解包的可选。



重要提示：不要使用隐式展开的可选，除非你必须。
使用它们不当会增加运行时崩溃的机会。 在某些情况下，崩溃可能是预期的行为，但是有更好的方法来实现相同的结果，例如，通过使用fatalError（）。*/

//要声明静态属性或函数，请在值类型上使用静态修饰符。
//这里有一个结构的例子：

struct Sun {
    static func illuminate() {}
}

Sun.illuminate()

//static使一个属性或一个函数静态和不可重写。
//通过使用类，可以覆盖属性或函数。
//
//当应用于类时，static将成为类final的别名。
//
//例如，在此代码中，编译器会在尝试覆盖illuminate（）时提示：


class Star {
    class func spin() {}
    static func illuminate() {}
}

class Moon : Star {
    override class func spin() {
        super.spin()
    }
//    override static func illuminate() { // error: class method overrides a 'final' class method
//        super.illuminate()
//    }
}

/*
可以使用扩展添加存储属性吗？
说明。

Answer:

不，这是不可能的。
扩展可用于向现有类型添加新行为，但不能更改类型本身或其接口。 如果添加了存储属性，则需要额外的内存来存储新值。 扩展无法管理此类任务。(表示不服，runtime，大家自己体会)
*/

//闭包是引用类型。
//如果一个闭包被分配给一个变量，并且该变量被复制到另一个变量中，那么也将复制对同一闭包及其捕获列表的引用。

//循环引用发生在两个实例彼此之间存在强引用时，从而导致内存泄漏，因为两个实例都不会被释放。
//原因是实例不能被释放，只要有一个强的引用，但每个实例保持另一个活着，因为它的强引用。
//
//你可以通过强弱循环引用来解决这个问题，用弱引用(weak)或者无主引用(unowned)替换其中一个强引用。




//不通过继承，代码复用（共享）的方式有哪些
//扩展, 全局函数

//实现一个 min 函数，返回两个元素较小的元素
func myMin<T: Comparable>(_ a: T, _ b: T) -> T {
    return a < b ? a : b
}
myMin(1, 2)
myMin(100, 5)



//什么是 copy on write时候
//写时复制, 指的是 swift 中的值类型, 并不会在一开始赋值的时候就去复制, 只有在需要修改的时候, 才去复制.


//如何声明一个只能被类 conform 的 protocol
//声明协议的时候, 加一个 class 即可
//如
protocol SomeClassProtocl: class {
    func someFunction()
}


//guard 使用场景
//
//guard 和 if 类似, 不同的是, guard 总是有一个 else 语句, 如果表达式是假或者值绑定失败的时候, 会执行 else 语句, 且在 else 语句中一定要停止函数调用
//例如
guard 1 + 1 == 2 else {
    fatalError("something wrong")
}




// MARK: - 字符串截取
extension String {
    /// String使用下标截取字符串
    /// string[index] 例如："abcdefg"[3] // c
    subscript (i:Int)->String{
        let startIndex = self.index(self.startIndex, offsetBy: i)
        let endIndex = self.index(startIndex, offsetBy: 1)
        return String(self[startIndex..<endIndex])
    }
    /// String使用下标截取字符串
    /// string[index..<index] 例如："abcdefg"[3..<4] // d
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    /// String使用下标截取字符串
    /// string[index,length] 例如："abcdefg"[3,2] // de
    subscript (index:Int , length:Int) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let endIndex = self.index(startIndex, offsetBy: length)
            return String(self[startIndex..<endIndex])
        }
    }
    // 截取 从头到i位置
    func substring(to:Int) -> String{
        return self[0..<to]
    }
    // 截取 从i到尾部
    func substring(from:Int) -> String{
        return self[from..<self.count]
    }
    
}


let str = "123456789"
let zero = str[str.startIndex]
let someIndex = str.index(str.startIndex, offsetBy: 4)
let five = str[someIndex]

let anotherIndex = str.index(str.endIndex, offsetBy: -3)
str[anotherIndex]
print(str[anotherIndex])

let substr = str.prefix(5)
let substr1 = str.suffix(5)

let str1 = str[6]    // 获取某一个下标的字符串
let str2 = str[2..<6]
let str3 = str[2,6]
let str4 = str.substring(to: 5)
let str5 = str.substring(from: 5)

let some1String = "今天你恰饭了吗"
// someRang的类型是 Range<String.Index>?
if let someRange = some1String.range(of: "恰饭") {
    print(some1String[someRange])
    // 恰饭
    print(some1String[someRange.lowerBound])
    // 恰
    print(some1String[someRange.upperBound])
    // 了
}



//public 和 open 的区别
//这两个都用于在模块中声明需要对外界暴露的函数, 区别在于, public 修饰的类, 在模块外无法继承, 而 open 则可以任意继承, 公开度来说, public < open

//Self 的使用场景
//Self 通常在协议中使用, 用来表示实现者或者实现者的子类类型.

//什么时候使用 @objc
//@objc 用途是为了在 Objective-C 和 Swift 混编的时候, 能够正常调用 Swift 代码. 可以用于修饰类, 协议, 方法, 属性.
//常用的地方是在定义 delegate 协议中, 会将协议中的部分方法声明为可选方法, 需要用到@objc


//声明一个只有一个参数没有返回值闭包的别名
//没有返回值也就是返回值为 Void
typealias SomeClosuerType = (String) -> (Void)
let someClosuer: SomeClosuerType = { (name: String) in
    print("hello,", name)
}
someClosuer("world")
// hello, world


//如何自定义下标获取
//实现 subscript 即可, 如
//
//extension AnyList {
//    subscript(index: Int) -> T{
//        return self.list[index]
//    }
//    subscript(indexString: String) -> T?{
//        guard let index = Int(indexString) else {
//            return nil
//        }
//        return self.list[index]
//    }
//}

//给集合中元素是字符串的类型增加一个扩展方法，应该怎么声明
//
//使用 where 子句, 限制 Element 为 String

extension Array where Element == String {
    var isStringElement:Bool {
        return true
    }
}


//dynamic framework 和 static framework 的区别是什么
//静态库和动态库, 静态库是每一个程序单独打包一份, 而动态库则是多个程序之间共享


//autoclosure 的作用
//自动闭包, 会自动将某一个表达式封装为闭包. 如
func autoClosureFunction(_ closure: @autoclosure () -> Int) {
    closure()
}
autoClosureFunction(1)


////下面代码中 mutating 的作用是什么
//struct Person {
//    var name: String {
//        mutating get {
//            return store
//        }
//    }
//}
//让不可变对象无法访问 name 属性






