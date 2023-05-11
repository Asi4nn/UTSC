def meaning_of_life(num_years):
    '''Return the meaning of life as calculated by a supercomputer after
    num_years years.'''
    return '... After %s years ...\n the answer is... %s\n' % (num_years, LIFE)

def report(f, arg):
    '''Return a report produced by f when called with argument arg. '''
    LIFE = "surprise!"
    return 'LIFE is %s\nREPORT: %s' % (LIFE, f(arg))

def report_again(arg):
    LIFE = "Now I'm confused."
    def meaning_of_life(num_years):
        '''Return the meaning of life as calculated by a supercomputer after
        num_years years.'''
        return '... After %s years ...\n the answer is... %s' % (num_years, LIFE)
    return 'LIFE is %s\nREPORT: %s' % (LIFE, meaning_of_life(arg))

if __name__ == '__main__':
    print(meaning_of_life)
    LIFE = 42
    print(report(meaning_of_life, 1000000))
    LIFE = 'Don\'t know.'
    print(report(meaning_of_life, 1000000))
    print(report_again(1000000))