Regular expressions allow you to specify a pattern of text to search for.
## Finding Patterns Of Text Without Regular Expressions
As an example, finding a phone number in a string: we know the patter is 3 numbers followed by a hyphen, 3 more numbers followed by another hyphen and 4 more numbers. Example: `415-555-4242`
Lets say we have a function `isPhoneNumber(text)` to check if a string contains a pattern for a phone number:

```python
def isPhone Number(text):
	if len(text) != 12:
		return False
	for i in range(0,3):
		if not text[i].isdecimal():
			return False
	if text[3] != '-':
	for i in range(4,7):
		if not text[i].isdecimal():
			return False
		return False
	if text[7] != '-':
		return False
	for i in range(8, 12):
		if not text[i].isdecimal():
		return False
	return True
```
The code checks if the string is 12 characters long, checks if the first 3 characters are numbers, checks for the 2 hyphens in the pattern, followed by checking if the next 3 characters are numbers, and lastly if the remaining 4 are characters ,,,,,,, . 
If all checks are passed then we return True, otherwise return False.

```python
message = 'Call me at 415-555-1011 tomorrow. 415-555-9999 is my office.'
for i in range(len(message)):
	chunk = message[i:i+12]
	if isPhoneNumber(chunk):
		print('Phone number found: ' + chunk)
print('Done')
```

In this code it searches on each iteration at i + the next 12 characters.
For example the first iteration searches `[0:12]` next is `[1:13]`
You keep passing in chunks until it finds that 12 character pattern.
If conditions are met we print out the valid chunks. 
## Finding Patterns Of Text With Regular Expressions
Our function for finding phone numbers is pretty good at only finding numbers with that specific format.
But once we start to introduce different formats, and other factors such as an extension number, we start to see its glaring weaknesses.
Regexes (regular expressions) are descriptions for a pattern of text.
For example `\d` stands for a digit character (any numeral from 0-9).
We can create more sophisticated patterns like `\d{3}-\d{3}-\d{4}`.
#### Creating Regex Objects
All regex functions are in the `re` module in Python `import re`.
Passing a string representing your regular expression to re.compile() returns a Regex pattern object.
`phoneNumRegex = re.compile(r'\d\d\d-\d\d\d-\d\d\d\d')`
Now phoneNumRegex contains a Regex object.
#### Matching Regex Objects
Search method takes in a string and matches it to the regex. 
If no pattern is found it returns None.
if found it returns a Match object.
Matched object contains a `group()` method that returns the string text of the matched object.

```python
phoneNumRegex = re.compile(r'\d\d\d-\d\d\d-\d\d\d\d')
mo = phoneNumRegex.search('My number is 415-555-4242')
print('Phone number found: ' + mo.group())

>>> Phone number found: 415-555-4242
```

The `mo` var is just a generic name used for `Match` objects.
We pass our desired pattern to `re.compile()` and store the resulting regex object inside of `phoneNumberRegex`. 
Next we use `search()` on `phoneNumberRegex` by passing it a string that we want to use to search for a match, The result is stored in the `mo` variable.
Finally we use `mo.group()` to returned the match, if there is one. 
#### Review Of Regular Expression Matching
1. Import the `re` regex module
2. Create a regex object with `re.compile()`.
3. Pass the string you want to search in the `search()`.
4. Call `group()` to return string of matched text. 

## More Pattern Matching With Regular Expressions
#### Grouping With Parentheses
Adding parentheses will create in groups, useful for something like area codes.
`regex: (\d\d\d)-(\d\d\d-\d\d\d\d)`
We can use the `group()` method and grab matching text from specific groups.

```python
phoneNumRegex = re.compile(r'(\d\d\d)-(\d\d\d-\d\d\d\d)')
mo = phoneNumRegex.search('My number is 415-555-4242.')
mo.group(1) 
>>> '415'
mo.group(2)
>>> '555-4242'
mo.group(0)
>>> '415-555-4242'
mo.group()
>>> '415-555-4242'
```

We can use the `groups()` method to return all groups
It returns a tuple of values, we can use the multiple assignment trick to separate the groups into their own variables.

```python
print(mo.groups())
>>> ('415', '555-4242')
areaCode, mainNumber = mo.groups()
print('Area Code:', areaCode)
>>> '415'
print('Main Number:', mainNumber)
>>> '555-4242'
```
#### Matching Multiple Groups With The Pipe
#### Optional Matching With The Question Mark
#### Matching Zero Or More With The Star
#### Matching One Or More With The Plus
#### Matching Specific Repetitions With Curly Brackets
## Greedy And Non Greedy Matching
## The findall() Method
## Character Classes
## Making Your Own Character Classes
## The Caret And Dollar Sign Characters
## The Wildcard Character 
#### Matching Everything With Dot-Star
#### Matching Newlines With The Dot Character
## Review Of Regex Symbols
## Case-Insensitive Matching
## Substituting Strings With The sub() Method
## Managing Complex Regexes 
## Combining re.IGNORECASE re.DOTALL And re.VERBOSE
## Project: Phone Number And Email Address Extractor
#### Step 1: Create A Regex For Phone Number
#### Step 2: Create A Regex For Email Addresses 
#### Step 3: Find All Matches In The Clipboard Text
#### Step 4: Join The Matches Into A String For The Clipboard
#### Running The Program
#### Ideas For Similar Programs
## Practice Questions
## Practice Projects
#### Strong Password Detection
#### Regex Version of strip()
