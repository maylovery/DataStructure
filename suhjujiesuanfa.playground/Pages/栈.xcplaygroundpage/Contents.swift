//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"



var timeStr = """
2:39:17
2:32:50
2:20:38
2:20:29
2:17:57
2:17:15
2:16:11
2:15:02
2:14:46
2:12:51
2:07:06
2:06:47
2:06:16
2:05:45
2:01:27
1:53:34
1:48:19
1:23:55
1:17:31
1:15:11
1:04:26
1:03:22
1:03:00
0:59:11
0:35:33
0:29:01
0:22:11
"""

let timeArr = timeStr.components(separatedBy: "\n")
var hour = 0
var minute = 0
var second = 0

for atime in timeArr {
    let temp = atime.components(separatedBy: ":").map({ Int($0) ?? 0 })
    let one = temp[0] ?? 0
    let two = temp[1] ?? 0
    let three = temp[2] ?? 0
    hour += one
    minute += two
    second += three
}
print("hour=\(hour) minute=\(minute)")

minute = minute + second/3600 // 538
second = second % 3600
hour = hour + minute/60 // 46
minute = minute % 60 // 58分

//约47个小时，2倍 23.5， 一天12个小时。







//20. 有效的括号
//https://leetcode.cn/problems/valid-parentheses/description/
/*
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

 */
func isValid(_ s: String) -> Bool {
    if s.count % 2 != 0 { return false }
    var map:[Character:Character] = ["(":")",
               "[":"]",
               "{":"}"]
    
    var statck: [Character] = []
    
    for char in s {
        if map[char] != nil {
            statck.append(char)
        } else {
            if statck.isEmpty || map[statck.last!] != char { return false }
            statck.popLast()
        }
    }
    return statck.isEmpty
    
}


// 856. 括号的分数 https://leetcode.cn/problems/score-of-parentheses/description/
/*
 给定一个平衡括号字符串 S，按下述规则计算该字符串的分数：
A是(). B 是一个()
 () 得 1 分。
 AB 得 A + B 分，其中 A 和 B 是平衡括号字符串。
 (A) 得 2 * A 分，其中 A 是平衡括号字符串。
 输入： "(()(()))"
 输出： 6
 */
func scoreOfParentheses(_ s: String) -> Int {
    // 1分治 2栈 3 直接求和
    var stack: [String] = []
    
    for char in s {
        if char == "(" {
            stack.append(String(char))
        } else {
            var sum = 0
            while let numStr = stack.last, let num = Int(numStr) {
                sum += num
                _ = stack.popLast()
            }
            sum = max(2 * sum, 1)
            stack.popLast()
            stack.append("\(sum)")
        }
    }
    var sum = 0
    for anu in stack {
        sum += (Int(anu) ?? 0)
    }
    return sum
}


//150. 逆波兰表达式求值 https://leetcode.cn/problems/evaluate-reverse-polish-notation/description/

func evalRPN(_ tokens: [String]) -> Int {
    /*
     输入：tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
     输出：22
     */
    /*
      ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
     ["10","6","12","-11","*","/","*","17","+","5","+"]
     ["10","6","-132","/","*","17","+","5","+"]
     ["10","0","*","17","+","5","+"]
     ["22"]
     */
    
    var stack: [Int] = []
    for astr in tokens {
        if let num = Int(astr) {
            // 10, 6,9,3
            stack.append(num)
        } else {
            var temp = 0
            let second = stack.popLast() ?? 1
            let first = stack.popLast() ?? 0
            switch astr {
            case "+":
                temp = first + second
            case "-":
                temp = first - second
            case "*":
                temp = first * second
            case "/":
                temp = first / second
            default:
                break
            }
            stack.append(temp)
        }
    }
    return stack.first ?? 0
    
}



// 224. 基本计算器 https://leetcode.cn/problems/basic-calculator/description/
func calculate(_ s: String) -> Int {
    /*
     输入：s = "(1+(4+5+2)-3)+(6+8)"
     输出：23
     
     (1+(4+5+2)-3)+(6+8)
     */
    func calculateSub(_ expression: String) -> String {
        // 只有加减-数字
        var ans = 0
        var str = ""
        for ch in expression {
            if ch == "+" {
                ans = ans + (Int(str) ?? 0)
                str = ""
            } else if ch == "-" {
                if !str.isEmpty {
                    ans = ans + (Int(str) ?? 0)
                }
                str = "-"
            } else {
                str.append(ch)
            }
        }
        ans = ans + (Int(str) ?? 0)
        return "\(ans)"
    }
    var chars = [Character]()
    var leftParentheses = [Int]()

    for char in s {
        if char == "(" || char == "+" || char == "-" || char.isNumber {
            chars.append(char)
            if char == "(" {
                // 记录上一次(的位置，下一次) 计算括号内的数值，重新push到chars 中
                leftParentheses.append(chars.count - 1)
            }
        } else if char == ")" {
            // 拿出需要计算的from
            let from = leftParentheses.removeLast() + 1
            var str = String(chars[from...])
            chars.removeLast(str.count + 1)
            // 计算括号内的结果
            str = calculateSub(str)
            
            if str.first! == "-" && !chars.isEmpty{
                str.removeFirst()
                let lastSymbol = chars.removeLast()
                if lastSymbol == "-"  {
                    chars.append("+")
                } else {
                    chars.append("-")
                }
            }
            chars.append(contentsOf: str)
        }
    }
    
    return Int(calculateSub(String(chars)))!
    
}



calculate("(1+(4+5+2)-3)+(6+8)")
calculate("- (3 + (4 + 5))")



