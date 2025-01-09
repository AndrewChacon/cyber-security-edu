import re

def isPhoneNumber(text):
    if len(text) != 12:
        return False
    for i in range(0,3):
        if not text[i].isdecimal():
            return False
    if text[3] != '-':
        return False
    for i in range(4,7):
        if not text[i].isdecimal():
            return False
    if text[7] != '-':
        return False
    for i in range(8,12):
        if not text[i].isdecimal():
            return False
    return True

message = 'Call me at 415-555-1011 tomorrow. 415-555-9999 is my office.'
for i in range(len(message)):
    chunk = message[i:i+12]
    # print(message[i:i + 12]) 
    # at each literation is searches a chunk of i (starting position) + the next 12 characters in the string
    if isPhoneNumber(chunk):
        print('Phone number found: ' + chunk)
print('Done')



# MATCHING REGEX OBJECTS

# compile takes our desired pattern
phoneNumRegex = re.compile(r'\d\d\d-\d\d\d-\d\d\d\d')
# pass string we want to search in the search method
mo = phoneNumRegex.search('My number is 415-555-4242')
# call group method to print matched text, if match is present
print('Phone number found: ' + mo.group())



# GROUPING WITH PARENTHESES

phoneNumRegex = re.compile(r'(\d\d\d)-(\d\d\d-\d\d\d\d)')
mo = phoneNumRegex.search('My number is 415-555-4242.')
print(mo.group(1)) # return group 1
print(mo.group(2)) # return group 2
print(mo.group(0)) # return entire group
print(mo.group()) # return entire group

print(mo.groups()) # returns all groups 
areaCode, mainNumber = mo.groups() # multiple assignment 
print('Area Code:', areaCode)
print('Main Number:', mainNumber)



# MATCHING GROUPS WITH PIPES

heroRegex = re.compile(r'firstname|last name') # pipe for multiple searches
mo1 = heroRegex.search('firstname drew last name chacon')
print(mo1.group()) # first occurance is found: 'firstname'
mo2 = heroRegex.search('last name chacon firstname andrew')
print(mo2.group()) # first occurance is found: 'last name'

batRegex = re.compile(r'Bat(man|mobile|copter|bat)') # specifying the prefex
mo = batRegex.search('Batmobile lost a wheel')
print(mo.group()) # returns fully matched text 'Batmobile'
print(mo.group(1)) # returns part of the matched text 'mobile'

