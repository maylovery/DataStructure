import UIKit

var greeting = "Hello, playground"


public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}



// 反转链表
func reverseList(_ head: ListNode?) -> ListNode? {
    if head == nil  { return nil }
    var cur = head
    var pre: ListNode?
    while cur != nil {
        var temp = cur?.next
        cur?.next = pre
        pre = cur
        cur = temp
    }
    return pre
}

// 移除链表元素
func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
    if head == nil { return nil }
    var head = head
    // 删除值相同的头节点
    while head != nil , head?.val == val {
        head = head?.next
    }
    
    var pre = head
    while pre?.next != nil {
        if pre?.next?.val == val {
            pre?.next = pre?.next?.next
        } else {
            pre = pre?.next
        }
    }
    
    return head
}


// 删除有序链表的重复元素
func deleteDuplicates(_ head: ListNode?) -> ListNode? {

    var cur = head
    while cur != nil, cur?.next != nil {
        if cur?.val == cur?.next?.val {
            cur?.next = cur?.next?.next
        } else {
            cur = cur?.next
        }
    }
    return head
}

// 返回单链表的中间节点, 快慢指针
func middleNode(_ head: ListNode?) -> ListNode? {
    
    var low = head
    var fast = head
    // 只有1个，或者只有2个
    if head?.next == nil { return head }
    if head?.next?.next == nil { return head?.next }
    
    while fast != nil, fast?.next != nil {
        fast = fast?.next?.next
        low = low?.next
    }
    return low
    
}

// 链表中是否有环
func hasCycle(_ head: ListNode?) -> Bool {
    var low = head
    var fast = head
    while fast?.next != nil {
        fast = fast?.next?.next
        low = low?.next

        if fast === low { return true }
    }
    return false
}
        
