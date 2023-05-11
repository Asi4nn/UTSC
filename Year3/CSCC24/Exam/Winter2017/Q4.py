class TreeNode:
    def __init__(self, value=None, children=None):
        self.value = value
        if children:
            self.children = list(children)
        else:
            self.children = []
            
    def __str__(self):
        return str(self.value)
    
def contains(root, value, equal):
    '''Return if the tree rooted at TreeNode root contains the given
    value. Uses binary function equal to compare values for equality.
    Do not use loops. Use any() and a generator expression. '''
    if root.value == value: return True

    return any(map(lambda x: equal(x, value), root.children))

def str_tree(root, offset=''):
    '''Return a somewhat readable str representation of a tree rooted at
    TreeNode root. See example for format. Do not use loops. Use list comprehension.'''
    return (offset + str(root.value) + '\n').join(
        [" " + str(v.value) + '\n' for v in root.children])

def tmap(func, root):
    '''Return a tree that results from applying func to every value stored
    in a tree rooted at TreeNode root. Do not use loops. Use map and
    a lambda expression.'''
    return TreeNode(func(root), map(lambda c: tmap(func, c), root.children))

def tmap2(func, root):
    '''Apply func to every value stored in a tree rooted at TreeNode root.
    Do not use loops. Use list comprehension. '''
    return TreeNode(func(root), [tmap2(func, c) for c in root.children])

if __name__ == '__main__':
    ROOT = TreeNode(-1,
                    [TreeNode(2, [TreeNode(-5), TreeNode(6)]),
                    TreeNode(3, [TreeNode(-7), TreeNode(8), TreeNode(9)]),
                    TreeNode(-4)])
    
    print(str_tree(ROOT))
    print(str_tree(tmap(abs, ROOT)))
    print(contains(ROOT, 8, int.__eq__))
    print(contains(ROOT, 42, int.__eq__))
    tmap2(abs, ROOT)
    print(str_tree(ROOT))