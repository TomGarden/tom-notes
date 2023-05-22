/************************************************************************************************
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
// 翻转单链 ，返回翻转后的链表头元素
class Solution {
    public ListNode reverseList(ListNode head) {
        //链表长度为 0 无需计算
        if(head == null) return head;
    }

    //迭代
    public ListNode reverseListIterator(ListNode head) {
        ListNode nodeA = null;
        ListNode nodeB = head;
        ListNode nodeC = head.next;
        while(true) {
            nodeB.next = nodeA;

            if(nodeC == null) break;
            nodeA = nodeB;
            nodeB = nodeC;
            nodeC = nodeC.next;
        }

        return nodeB;
    }

    // 递归——内存溢出
    public ListNode reverseListRecursive(ListNode pre , ListNode cur) {
        ListNode result = null;
        if(cur.next != null) {
            result = reverseListRecursive(cur , cur.next);
        }
        if(result == null) result = cur;
        cur.next = pre;
        return result;
    }

    // 递归——通过
    public ListNode reverseListRecursive(ListNode start , ListNode mid , ListNode end) {
        mid.next = start;
        if(end == null) return mid;
        return reverseListRecursive(mid , end , end.next);
    }
}



/************************************************************************************************
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
//  合并两个有序链表
class Solution {
    public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        if(l1 == null)return l2;
        if(l2 == null)return l1;

        ListNode result = null;
        if(l1.val >= l2.val){
            result = new ListNode(l2.val);
            l2 = l2.next;
        } else {
            result = new ListNode(l1.val);
            l1 = l1.next;
        } 

        ListNode temp = result;
        while(l1 != null || l2 != null) {
            if(l1 == null) {
                temp.next = l2;
                break;
            } else if(l2 == null) {
                temp.next = l1;
                break;
            } else {
                if(l1.val >= l2.val){
                    temp.next = new ListNode(l2.val);
                    l2 = l2.next;
                } else {
                    temp.next = new ListNode(l1.val);
                    l1 = l1.next;
                } 
            }

            temp = temp.next;
        }

        return result;
    }
}

/************************************************************************************************
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    // > 不满足进阶要求的做法，先翻转，然后对比，两个链表是相同的即可判定为回文链
    // > 进阶要求暂不满足
    // > 当前时间复杂度为 O(n^2)
    public boolean isPalindrome(ListNode head) {
        if(head == null || head.next == null) return true;
        
        //逐个翻转逻辑
        ListNode nodeA = null;
        ListNode nodeB = head;
        ListNode nodeC = head.next;
        while(true) {
            nodeB.next = nodeA;

            if(isPalindrome(nodeB , nodeC) == true) return true;
            if(nodeC == null) return false;
            else if (isPalindrome(nodeB , nodeC.next) == true) return true;
            nodeA = nodeB;
            nodeB = nodeC;
            nodeC = nodeC.next;
        }

    }
    
    //对比逻辑
    public boolean isPalindrome(ListNode head1 , ListNode head2) {
        while(head1!=null && head2!=null && head1.val == head2.val) {
            head1 = head1.next;
            head2 = head2.next;
        }
        
        if(head1 == null && head2 == null) return true;
        else return false;
    }
}



/************************************************************************************************
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
//  删除倒数第N个节点并返回头结点
class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {

    }

    // 普通解法,不满足进阶要求，先遍历计数，然后二次遍历删除指定位置节点
    public ListNode removeNthFromEnd_1(ListNode head, int n) {

        if(head == null) return head ;

        ListNode temp = head;

        if(n == 1) {
            if(head.next == null) return null;
            while(true) {
                if(temp.next.next == null) {
                    temp.next = null;
                    return head;
                } else temp = temp.next;
            }
        }

        int length = 1 ;
        while(temp.next!=null) {
            temp = temp.next;
            length++ ;
        }

        temp = null;
        for(int i = 0; i<length ; i++) {
            if(temp == null) temp = head;
            else temp = temp.next;
            if(i == length - n) {
                temp.val = temp.next.val;
                temp.next = temp.next.next;
                break;
            }
        }

        return head;
    }

    // 查看了其他人的实现方式感觉思路还是还是比较巧妙的
    // 如果不增加一个 flag(头结点) 当删除的节点恰好为 head 的时候会出问题
    public ListNode removeNthFromEnd_2(ListNode head, int n) {
        ListNode flag = new ListNode(0) ;
        flag.next = head;

        ListNode start ;
        ListNode end ;

        start = flag;
        end = flag;
        for(int i = 0 ; i<n ; i++) {
            end = end.next;
        }

        while(end.next!=null) {
            start = start.next;
            end = end.next;
        }

        start.next = start.next.next;

        return flag.next;
    }

    public ListNode removeNthFromEnd_2(ListNode head, int n) {
        if(head == null) return head ;
        if(head.next == null) return null;

        ListNode flag = new ListNode(0) ;
        flag.next = head;


        if(head == null) return head ;
        if(head.next == null) return null;

        ListNode start ;
        ListNode end ;

        start = head;
        end = head;
        for(int i = 0 ; i<n ; i++) {
            end = end.next;
        }

        while(end.next!=null) {
            start = start.next;
            end = end.next;
        }

        start.next = start.next.next;

        return head;
    }


    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dump = new ListNode(0);
        ListNode fast = dump;
        ListNode low = dump;
        dump.next = head;
        
        
        int i = 0;
        while(i++<=n){
            fast = fast.next;
        }
        
        while(fast != null){
            low = low.next;
            fast = fast.next;
        }
        
        low.next = low.next.next;
        
        
        return dump.next;
    }
}

