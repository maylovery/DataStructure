//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

public class Node {
    public var val: Int
    public var children: [Node]
    public init(_ val: Int) {
        self.val = val
        self.children = []
    }
}
// root = [1,null,3,2,4,null,5,6] 3
func maxDepth(_ root: Node?) -> Int {
    // 递归 取左右深度的最大值 + 1
    // 广度优先遍历，队列存节点，一层记录size，每取一个size--， 跳出一层循环时，depth 加一
}

// 662. 二叉树最大宽度
func widthOfBinaryTree(_ root: TreeNode?) -> Int {
 // 层序遍历，每个节点加编号，用数组存储每一层的元素，遍历完成之后 重新取下一层，
    // 在遍历x层时，最多遍是啊arr[0].index, 最右边是arr[arr.leng-1].index
}


// 有序数组的平方 [-4, -1, 0, 3, 10]
func sortArrPingFa(arr: [Int]) {
    // 找出负数的index
    var negIndex = -1
    arr.enumerated().forEach { index, value in
        if value < 0 {
            negIndex = index
        } else {
            return
        }
    }
    var newArr = Array(repeating: 0, count: arr.count)
    var index = 0 // 新数组的存储位置
    var i = negIndex // 负数索引 1
    var j = negIndex + 1; // 正数 2
    let n = arr.count ; // 4
    // [-4, -1, 0, 3, 10]
    while i >= 0 || j < n {
        if i < 0 {
            // 负数处理完了，全是正数
            newArr[index] = arr[j] * arr[j]
            j += 1
            print(4)
        } else if j == n {
            // 正数处理结束了，全是负数
            newArr[index] = arr[i] * arr[i]
            i -= 1
        } else if arr[i] * arr[i] < arr[j] * arr[j] {
            // 正数大于负数
            newArr[index] = arr[i] * arr[i]
            i -= 1
        } else {
            // 负数大于正数
            newArr[index] = arr[j] * arr[j]
            j += 1
        }
        index += 1
    }
    print(newArr)
}
sortArrPingFa(arr: [-4, -1, 0, 3, 10])


func findPartSort(arr: [Int]) {
    // 正向找last， 比扫描过的最大值小
    var last = 0
    var tempMax = arr[0]
    arr.enumerated().forEach { index, value in
        if value > tempMax {
            tempMax = value
        } else {
            last = index
        }
    }
    
    // 逆向找first， 比扫描过的最小值大
    var first = 0
    var tempMin = arr[arr.count - 1]
    arr.enumerated().reversed().forEach { index, value in
        if value < tempMin {
            tempMin = value
        } else {
            first = index
        }
    }
    print("\(first)-\(last)")
}
// 3-9, 7,10,11,7,12,6,7 排好序
findPartSort(arr: [1,2,4,7,10,11,7,12,6,7,16,18,19])



// 颜色分类, 数组内只有0，1，2
func sortColor(arr: [Int]) -> [Int] {
    var arr = arr
    var p1 = 0
    var p0 = 0
    var p2 = arr.count - 1
    while p1 <= p2 {
        let num = arr[p1]
        if num == 0 {
            arr[p1] = arr[p0]
            arr[p0] = num
            p0 += 1
            p1 += 1
        } else if num == 1 {
            p1 += 1
        } else {
            arr[p1] = arr[p2]
            arr[p2] = num
            p2 -= 1
        }
    }
    return arr
}

print(sortColor(arr: [2,0,2,1,1,0]))




// 有序数组合并， num1 1，3，5 0 0 0； num2= 2，4，6
func mergeArr(num1: [Int], num2: [Int]) {
    let i1 = num1.count - 1
    let i2 = num2.count - 1
    let cur = i1 + i2 -1
    while i2 > 0 {
        if i1 > 0, num1[i1] > num2[i2] {
            num1[cur] = num1[i1]
            cur -= 1
            i1 -= 1
        } else {
            num1[cur] = num2[i2]
            cur -= 1
            i2 -= 1
        }
    }
}




