## Client-Server Model
clients request resources or services servers provide those resources and services.
Like a web server and client using a browser relationship.
Could return files such as HTML, CSS, and JS.
Web APIs also allow for apps to request data of other systems enabling apps to share data and resources in a controlled manner. 
## The Domain Name System
Every device has has an IP address, this allows other devices to find it and connect. 
DNS (domain name system) acts like a phone book for the internet.
They translate domain names into IP addresses for us to make requests to. 
## Internet Ports
The browser will attempt to connect to the IP address via a port. 
They allow for servers to provide multiple services to the internet at the same time.
If an internet client connects to port 80, the server knows its for a web services 
## HTTP Requests And Responses
Browser and server communicate via HTTP (hyper text transfer protocol) which is a set of rules defining how communication will be exchanged.
When your browser wants to communicate with a server it sends an HTTP request.
###### HTTP Request:
Request line specifies the method, requested URL, and version of HTTP used.
Request headers are used to pass additional information about the request
These include:
- User-Agent: contains operating system and software version of requesting software.
- Accept, Accept-Language, Accept-Encoding: tells server what format data should be in.
- Connection: if network connection should stay open or closed after server response.
###### HTTP Response
Contains status code for response, HTTP headers, HTTP response body
These headers contain extra info about stuff like authentication, content format, and security policies. 
The HTTP body is just the actual content of the web page.
Once the browser receives all the info needed to build the web page it'll render it for you. 
## Internet Security Controls
To hunt for bugs you'll have to learn creative ways to bypass these controls but first we need to understand how they work.
### Content Encoding
Data transmitted from HTTP req and res aren't always in plain text, websites often encode their messages in different ways to prevent data corruption. 
Data Encoding is used as a way to transfer binary data across machines that have limited support for different content types. 
Base64 encoding is one of the most common ways, often used to transporting images and encrypted information with in web messages. 
Base64 includes uppercase A-Z, lowercase a-z, numbers 0-9, and +, /, =
URL Encoding is a way of encoding characters into a format that makes it easier to transmit over the internet. 
When you find encoded content always try to decode it so you can find out what the website is trying to transmit. 
Some servers might encrypt before transmission to prevent people from eavesdropping. 
### Session Management And HTTP Cookies
Session management is a process that allows the server to handle multiple requests from the same user without asking the user to log in again. 
The server will assign an associated session ID fro the browser as proof of identity.
Websites will create a session and assign a cookie that it checks on every request.
The cookie will expire if the user logs out or after some unspecified amount of time passes. 
The server will track the cookie and use it as a way to validate your identity. 
Upon logging out the cookie cannot be used anymore, at the beginning of the new session a fresh unique cookie will be generated for you again.
### Token-Based Authentication
In session based authentication the server stores your info and uses a session ID to validate your identity, whereas token based authentication stores this info directly in some token. 
Tokens allow servers to deduce your identity by decoding the token itself. 
This method makes it so session info doesn't need to be stored server side.
These tokens can still be manipulated and tampered with but its a lot harder than normal tokens.
Another way of protecting the integrity of the token is by verifying the signature of the token when it arrives at the server, a signature is a way to verify the integrity of a piece of data. 
Special strings that can be generated using a secret key, only the server would know the key.
1. user logs in with credentials.
2. server validates credentials and provides a signed token.
3. User sends token with every request.
4. server reads users identity from the token and responds with data.
### JSON Web Tokens
JWT (json web token), the most commonly used token uses 3 components.
1. Header: Identifies the algorithm used to generate the signature, base64url.
2. Payload: Contains info of the users identity, also base64url before used by the token.
3. Signature: Validates that the user hasn't tampered with the token, its calculated by concatenating the header with the payload, then signing in with the algorithm specified in the header and secret key.  
if implemented properly this way provides a secure way of identifying a user, if implemented incorrectly there are ways an attacker can bypass security mechanisms. 
##### Manipulating The ALG Field
Sometimes an app fails to verify a tokens signature after it arrives at the server, allowing hackers to bypass by providing an invalid or blank signature. 
Tampering with the ALG field, if an app doesn't restrict the algorithm type an attacker can specify which algorithm to use. 
If an ALG field is set to none then even tokens with empty signatures would be considered valid.
Attackers might also change the algorithm being used to create valid signatures from forged tokens. 
##### Brute-Forcing The Key
if the key isn't complex enough they can brute force a guess.
Other attacks like directory traversal allows an attacker to search and read the file containing the secret key value. 
##### Reading Sensitive Information
If a token is not encrypted anyone can base64 decode the token and read its payload.
JWTs provide data integrity not confidentiality. 
They can be secure but only if properly implemented. 
### Same-Origin Policy 
SOP (same origin policy) is a rule that restricts how a script from one origin can interact with the resources of a different origin. (the same base URL).
Protects resources being obtained by other origins that do not share the same domain.
### Learn To Program
Python and shell scripting to automate tasks.