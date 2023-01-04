'''def longest_palindrone(text):
    longest = ''
    for i in range(1, len(text) + 1):
        if text[0:i] == text[i-1::-1] and len(text[0:i]) > len(longest):
            longest = text[0:i]
        elif text[i:len(text)] == text[:i-1:-1] and len(text[i:len(text)]) > len(longest):
            longest = text[i:len(text)]
    return longest

print(longest_palindrone('babad'))
'''

x = '1234567890'
#print(x[3:1:-2])
#print(x[3:][:6][::-2])
print(type([]) == type([1]))
