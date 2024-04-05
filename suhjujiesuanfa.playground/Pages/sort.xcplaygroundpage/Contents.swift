//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)



var arr1 = [10,8,1,0, 9, 2,4,3,7]


// 冒泡排序
func sort1() {
    for end in (1..<arr1.count).reversed() {
        for begin in 1...end {
            if arr1[begin] < arr1[begin - 1] {
                let temp = arr1[begin]
                arr1[begin] = arr1[begin - 1]
                arr1[begin - 1] = temp
            }
        }
    }
    
    print(arr1)
}

// 冒泡排序优化，已排序的，不再参与排序
func sort2() {
    for end in (1..<arr1.count).reversed() {
        var sorted = true
        for begin in 1...end {
            if arr1[begin] < arr1[begin - 1] {
                let temp = arr1[begin]
                arr1[begin] = arr1[begin - 1]
                arr1[begin - 1] = temp
                sorted = false
            }
        }
        // 已经排序的，跳出本次内循环
        if sorted { break }
    }
    
    print(arr1)
}


// 冒泡排序优化，已排序的，不再参与排序, 尾部已经是有序的，控制外层提前结束
func sort3() {
    for var end in (1..<arr1.count).reversed() {
        var endIndex = 1
        for begin in 1...end {
            if arr1[begin] < arr1[begin - 1] {
                let temp = arr1[begin]
                arr1[begin] = arr1[begin - 1]
                arr1[begin - 1] = temp
                endIndex = begin
            }
        }
        // 已经排序的，跳出本次内循环
        end = endIndex
    }
    
    print(arr1)
}



// 选择排序
func sort4() {
    // 选择第一和最后一个比较交换，大的放后面 [10,8,1,0, 9, 2,4,3,7]
    for end in (1..<arr1.count).reversed() {
        var maxIndex = 0
        for begin in 1...end {
            if arr1[maxIndex] < arr1[begin] {
                maxIndex = begin
            }
        }
        // 找到了最大的，交换
        let temp = arr1[maxIndex]
        arr1[maxIndex] = arr1[end]
        arr1[end] = temp
    }
    print(arr1)
}

// 插入排序-基础 从后序列中那一个，在他之前都是排好序的，遍历找到合适的位置插入
func sort5() {
    for begin in (1..<arr1.count) {
        var current = begin
        while current > 0, arr1[current] < arr1[current - 1] {
            let temp = arr1[current]
            arr1[current] = arr1[current - 1]
            arr1[current - 1] = temp
            current -= 1
        }
    }
    print(arr1)
}
// 插入排序-优化，上面交换修改为 整体挪动位置
func sort6() {
    for begin in (1..<arr1.count) {
        var current = begin
        let value = arr1[current] // 先保存当前数字
        // 挪动位置
        while current > 0, value < arr1[current - 1] {
            arr1[current] = arr1[current - 1]
            current -= 1
        }
        arr1[current] = value
    }
    print(arr1)
}
// 插入排序-优化，使用二分查找到合适位置
func sort7() {
    for begin in (1..<arr1.count) {
        let value = arr1[begin] // 先保存当前数字
        let index = search(index: begin) // 使用二分查找到合适位置
        
        for i in stride(from: begin, to: index, by: -1) {
            arr1[i] = arr1[i-1] // 向后挪动位置1
        }
        
        arr1[index] = value
    }
    print(arr1)
    
    //  二分查找
    func search(index: Int) -> Int {
        var begin = 0
        var end = index
        while begin < end {
            let mid = (begin + end ) >> 1
            if arr1[index] < arr1[mid] {
                end = mid
            } else {
                begin = mid + 1
            }
        }
        return begin
    }
}

// 快速排序-
func sort8() {
    sort(begin: 0, end: arr1.count)
    print(arr1)
    
    func sort(begin: Int, end: Int) {
        if end - begin < 2 { return }
        // 找到定位点，左边的都比他小，右边的都比他大
        let pIndex = pIndex(begin: begin, end: end)
        sort(begin: begin, end: pIndex)
        sort(begin: pIndex + 1, end: end)
    }
    
    func pIndex(begin: Int, end: Int) -> Int {
        var b = begin
        var e = end - 1
        let pValue = arr1[b]
        
        while b < e {
            while b < e {
                
                if pValue < arr1[e] {
                    e -= 1
                } else {
                    arr1[b] = arr1[e] // 交换左边的
                    b += 1
                    break
                }
            }
            
            while b < e {
                if pValue > arr1[b] {
                    b += 1
                } else {
                    arr1[e] = arr1[b] // 交换右边的
                    e -= 1
                    break
                }
            }
        }
        arr1[e] = pValue
        return e
    }
}

// 归并排序-分割-merge 有序数组合并-递归
func sort9() {
    var leftArr = Array(repeating: 0, count: arr1.count >> 1)
    sort(begin: 0, end: arr1.count)
    
    print(arr1)
    func sort(begin: Int, end: Int) {
        if end - begin < 2 { return }
        // 找到定位点，左边的都比他小，右边的都比他大
        let mid = (begin + end) >> 1
        sort(begin: begin, end: mid)
        sort(begin: mid, end: end)

        merge(begin: begin, mid: mid, end: end)
    }
    // 2个有序数组的合并
    func merge(begin: Int, mid: Int, end: Int) {
        
        var leftIndex = 0
        var leftEnd = mid - begin
        
        var rightIndex = mid
        var rightEnd = end
        var arrIndex = begin
        
        for i in leftIndex..<leftEnd {
            leftArr[i] = arr1[begin + i] // 临时保存到 leftArr
        }
        
        while leftIndex < leftEnd {
            if rightIndex < rightEnd, arr1[rightIndex] < leftArr[leftIndex] {
                arr1[arrIndex] = arr1[rightIndex]
                rightIndex += 1
            } else {
                arr1[arrIndex] = leftArr[leftIndex]
                leftIndex += 1
            }
            arrIndex += 1
        }
    }
}

// 希尔排序-步长
func sort10() {
    var shellSteps: [Int] = []
    var count = arr1.count >> 1
    while count > 0 {
        shellSteps.append(count)
        count = count >> 1
    }
    
    print(shellSteps)
    
    for step in shellSteps {
        sortFor(setp: step)
    }
    print(arr1)
    
    func sortFor(setp: Int) {
        for col in 0..<setp {
            for begin in stride(from: col + setp, to: arr1.count, by: setp) {
                var current = begin
                while current > col, arr1[current] < arr1[current - setp] {
                    let temp = arr1[current]
                    arr1[current] = arr1[current - setp]
                    arr1[current - setp] = temp
                    current -= setp
                }
            }
        }
    }
    
}
// 堆排序
func sort11() {
    
    var heapSize = arr1.count
    // 原地建堆-自底向上的下滤
    for i in (1 ..< heapSize >> 1 - 1).reversed() {
        shifDown(index: i)
    }
    // 最下的交换到上面，开始下滤
    while heapSize > 1 {
        heapSize -= 1
        let temp = arr1[0]
        arr1[0] = arr1[heapSize]
        arr1[heapSize] = temp
        shifDown(index: 0)
    }
    
    func shifDown(index: Int) {
        var tempIndex = index
        let ele = arr1[index]
        
        let half = index >> 1
        while tempIndex < half {
            var childIndex = (tempIndex >> 1) + 1
            var child = arr1[childIndex]
            let rightIndex = childIndex + 1
            if rightIndex < heapSize, arr1[rightIndex] > child {
                childIndex = rightIndex
                child = arr1[childIndex]
            }
            
            if ele >= child { break }
            arr1[tempIndex] = child
            tempIndex = childIndex
        }
        arr1[tempIndex] = ele
    }
}

// 计数排序
func sort12() {
    
}

sort10()


