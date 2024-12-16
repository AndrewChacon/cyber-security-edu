### Web App Basics
based on the client/server model which means the web browser acting as the client makes requests for resources that reach a web server.
These web servers send resources back to the client over the network.
Web Application is a term that refers to software that runs on a web server just like twitter and reddit does.
Allow for communication to flow in both directions, server and client relationship.
#### The URL
also known and uniform resource locator, is the address used to locate resources on the internet, a URL consists of several components of information. 
They include: protocol, hostname, port, path, and query parameters.
	Protocol://hostname:port_number/path/?query:parameters
Protocols are a set of rules used to communicate, used within the URL on HTTP/HTTPS for webpages and FTP (file transfer protocol)
Port number specifies a comms channel, only included if the host didn't resolve.  
The path specifies the location of the web pages and files in the URL, same path used to locate files on a computer.
Query is extra bits of optional data used in functionality when making a request like searching. Information such as session ID or users email.
can contain multiple parameters in a URL separated by a (&) character. 
#### HTTP Requests
navigating a URL makes the browser generate an HTTP request for the page.
Resource is info being requested - the files that make the web page. 
if the request is properly formed the web server passes the request to the web application.

```
POST /sessions HTTP/1.1
Host: twitter.com
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Content-Type: application/x-www-form-urlencoded
Content-Length: 444
Cookie: _personalization_id=GA1.2.1451399206.1606701545; dnt=1;

username_or_email%5D=hAPI_hacker&password%5D=NotMyPassword%21
```

HTTP request start with the method, path of requested resource, protocol version, method, such as GET POST PUT AND DELETE, designates the domain host. 
User-Agent header describes the clients browser and operating system. 
Accept header describes what types of content the browser can accept. 
Anything below the header is the message body which is information that the requestor is attempting to process through the web application. 
The body consists of a username and password to authenticate, special characters are encoded during this process. 
Web encoding is how we deal with special characters not causing us issues. 
#### HTTP Responses
After a web server receives an HTTP request it'll process it and respond. 
A Response depends on how available the resource is, user auth to access it, and the health of the web server. 

```
HTTP/1.1 302 Found
content-security-policy: default-src 'none'; connect-src 'self'
location: https://twitter.com/
pragma: no-cache
server: tsa_a
set-cookie: auth_token=8ff3f2424f8ac1c4ec635b4adb52cddf28ec18b8; Max-Age=157680000;
Expires=Mon, 01 Dec 2025 16:42:40 GMT; Path=/; Domain=.twitter.com; Secure; HTTPOnly;
SameSite=None

<html><body>You are being <a href="https://twitter.com/">redirected</a>.</body></html>
```

Web server responds first with the protocol version in use: `HTTP/1.1`
The status code of the message `302` indicates successful authentication, they will be redirected to a landing page the client is not authorized to access. 
Similar to HTTP request headers, HTTP response headers provide the browser with instructions for handling the response and security requirements. 
the `set-cookie` header is another sign that the auth request was successful.
The web server issues a cookie that includes an `auth_token` which is needed for the client to access certain resources. 
Web authentication is the process of providing your identity to a web server.
Common forms of auth include giving a password, token, or biometric info.
if a web server approve the auth request it'll respond by providing the authenticated user, authorization to access certain resources.
HTTP traffic is sent in cleartext, meaning if intercepted the user can read the username and password due to no encryption in the protocol.
HTTPS requests add a layer of encryption with the TLS (transport layer security).
#### HTTP Status Codes
When a web server responds to a request it issues a response in the form of a status code along with a response message. 
The value of the code is an indication of how the request was handled. 

```
HTTP/1.1 200 OK    Server: tsa_a    Content-length: 6552

<!DOCTYPE html>
<html dir="ltr" lang="en">
[...]
```

```
HTTP/1.1 404 Not Found    Server: tsa_a    Content-length: 0
```

A 200 OK response provides the client with access to requested resource.
A 404 Not Found response will provide an error page to the client. 

| Response Code | Response Type        | Description                                                                                                             |
| ------------- | -------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| 100s          | Info based responses | related to processing status<br>update regarding request.                                                               |
| 200s          | Successful responses | Indicate successful and accepted<br>request.                                                                            |
| 300s          | Redirects            | Notifies of redirect, common for <br>request to redirect to index or<br>home page.                                      |
| 400s          | Client errors        | Indicates an error from the clients<br>side, such as requesting a page <br>that doesn't exist.                          |
| 500s          | Server errors        | Indicates an error from the server<br>side. Internal server errors, unavailable services, unrecognized request methods. |
#### HTTP Methods
request information from a web server, also known as HTTP verbs.
They include: GET, PUT, POST, HEAD, PATCH, OPTIONS, TRACE, DELETE.
Web APIs typically only use the GET, POST, PUT, DELETE methods.

| Method  | Purpose                                                                                                                 |
| ------- | ----------------------------------------------------------------------------------------------------------------------- |
| GET     | attempts to get any type of resource from the web server such as<br>web page, user data, video, etc.                    |
| POST    | attempts to submit data to a web server to be stored such as records, requests for money transfer, status updates, etc. |
| PUT     | attempts to submit data to a web server, not as a new entry but to update a currently existing record.                  |
| HEAD    | similar to GET but attempts to request the HTTP headers only                                                            |
| PATCH   | attempts to partially update an existing resource                                                                       |
| OPTIONS | allows a client to identify all request methods allowed on the given web server                                         |
| TRACE   | primary used for debugging purposes, asks the server to echo back the clients original request.                         |
| CONNECT | attempts to request a two way connection, if successful creates a proxy tunnel between browser and web server           |
| DELETE  | attempts to remove a currently existing resource                                                                        |
#### Stateful and Stateless HTTP
HTTP is stateless which means the server doesn't keep track of information between requests. 
However in order to have things like a consistent experience with the web app, the web server needs to remember some data about the HTTP session. 
A stateful connection uses cookies, to store small pieces of data about the user on the browser such as auth related info, site specific data, or security options.
Hackers will try to impersonate a user by stealing or forging their cookies.
There are scaling limitations in stateful connections, an authentication exists between that specific browser and user.
If a users moves to a different browser or device a re-authentication is necessary to create a new state with the server. 
Stateless communications eliminate the need for server resources to manage sessions.
The server doesn't store any information, all stateless requests must include all necessary info for the web server to recognize that authorized requestor for access to protected resources.  

### Web Server Databases
Databases allow servers to store client data and access it quickly.
They can be maintained by a company on their own and use them as a service.
#### SQL
also known as Structured Query Language, these databases are relational which means that they are stored in tables that are connected to each other. 
Uses an ID method for records to find specific records and their values. 
SQL injection is a classic way to attack web apps.
#### NoSQL
these databases are non relational meaning they don't follow the structures of a relational database.
Store data in documents instead of using relationships with key value pairs. 

### How APIs Fit Into The Picture
A web app can be more powerful by using the power of other applications.
APIs work like a channel that allows applications to communicate with other applications.
Machine to machine communication based on HTTP. 
This has opened the world up to many new opportunities for application providers reducing the need for lots of specialization for every aspect of an app.
A ride-sharing app can leverage APIs for things like google maps for map data, Stripe for processing payments, and Twilio for SMS messaging. 
A developer can use these well defined and developed services to create this kind of application without the need for building the infrastructure from scratch. 