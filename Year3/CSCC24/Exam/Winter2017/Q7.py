class BinaryTree(metaclass=ABCMeta):
    '''Abstract Base Class for binary trees.'''

    @abstractmethod
    def num_nodes(self):
        '''Return the number of nodes in this BinaryTree.'''

    @abstractmethod
    def inorder(self):
        '''Return a list of values from this BinaryTree in the in-order
        traversal order.'''


class Empty(BinaryTree):
    def num_nodes(self):
        return 0
    
    def inorder(self):
        return []
    
    def __str__(self) -> str:
        return "_"

class Node(BinaryTree):
    value = 0
    left, right = None

    def __init__(self, value, left=Empty(), right=Empty()):
        self.value = value
        self.left = left
        self.right = right

    def num_nodes(self):
        return self.left.num_nodes() + self.right.num_nodes() + 1
    
    def inorder(self):
        return self.left.inorder().append(self.value) + self.right.inorder()
    
    def __str__(self) -> str:
        return (self.left.__str__(), self.value, self.right.__str__())
    
    def __eq__(self, __value: object) -> bool:
        return isinstance(__value) == Node and self.inorder().sort() == __value.inorder().sort()


if __name__ == '__main__':
    EMPTY = Empty()
    print('Empty tree:')
    print(EMPTY)
    print('inorder: %s' % EMPTY.inorder())
    print('num_nodes: %s' % EMPTY.num_nodes())
    print()
    TREE = Node(5,
        Node(4, Node(3)),
        Node(9,
            Node(7, Node(6), Node(8)),
            Node(10)))
    print('TREE:')
    print(TREE)
    print('inorder: %s' % TREE.inorder())
    print('num_nodes: %s' % TREE.num_nodes())
    print()
    OTHER_TREE = Node(9,
        Node(4, Node(10), Node(8)),
        Node(3,
            Node(5, Node(7), Node(6))))
    print('OTHER_TREE:')
    print(OTHER_TREE)
    print('TREE == OTHER_TREE: %s' % (TREE == OTHER_TREE))