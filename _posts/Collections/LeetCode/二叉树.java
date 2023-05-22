
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
// 递归遍历二叉树
void traversingBinaryTree(TreeNode root) {
    if(root != null) {//调整本语句块的语句顺序可完成先序(中左右)、中序(左中右)、后序(左右中)三种遍历方式
        traversingBinaryTree(root.left) ;
        System.out.println(root.val) ;
        traversingBinaryTree(root.right) ;
    }
}

{// 非递归遍历二叉树 中序
    List<TreeNode> list = new ArrayList<>();

    void iteratorBinaryTree(TreeNode root) {
        nodeAdd2List(root) ;

        while(!list.isEmpty()) {    
            TreeNode lastNode = list.remove(list.size() - 1);
            System.out.println(lastNode.val) ;
            nodeAdd2List(lastNode.right)
        }

    }

    void nodeAdd2List(TreeNode node) {
        if(node != null) {
            list.add(node);
            while(node.left != null) {
                node = node.left ; 
                list.add(node) ;
            }
        } 
    }
}

{// 非递归遍历二叉树 先序
    List<TreeNode> list = new ArrayList<>();

    void iteratorBinaryTree(TreeNode root) {
        nodeAdd2List(root) ;

        while(!list.isEmpty()) {    
            TreeNode firstNode = list.remove(list.size() - 1);
            nodeAdd2List(firstNode.right)
        }
    }

    void nodeAdd2List(TreeNode node) {
        if(node != null) {
            System.out.println(node.val) ;
            list.add(node);
            while(node.left != null) {
                node = node.left ; 
                System.out.println(node.val) ;
                list.add(node) ;
            }
        } 
    }
}