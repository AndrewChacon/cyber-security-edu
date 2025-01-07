## Choosing An Operating System
The operating system you use will limit the tools you can use to pull off hacks.
Use Unix based systems such as Kali Linux, this is a linux based distribution that was developed specifically for digital forensics and hacking. 
## Setting Up The Essentials: A Browser And A Proxy
A proxy is a software that sits between a client and a server, it allows us to intercept requests and responses coming in and out of the client/server relationship.
`Browser <-----> Proxy <-----> Server`
Proxies allow us to view and modify these requests and responses.
We can perform recon by analyzing the traffic going to and from the server.
## Using Burp 
burp suite has many useful features aside a long side the web proxy.
### The Proxy
Every request send will go through Burp and wont send them to the server unless we manually forward them, allows us to make modifications before sending requests. 
### The Intruder
Used for automating attacks, automates request sending.
Brute forcing, attacker submits many requests with each one being slightly altered. 
Intruder gives us several ways to customize our attacks.
Payloads are data you want to insert at specific positions. 
Payload Positions specify which parts of the request will be modified. 
Using an example of a POST request to login, we could brute force many usernames and passwords in an attempt to gain authentication. 
### The Repeater
Used for manipulating individual requests, modify requests and examine server responses.
Meant for manual, detailed modifications of a single request. 
Good for manual bug exploitation, by passing filters, testing out attack methods on an endpoint.
### The Decoder
Used for decoding and encoding content that you find from requests. 
Decode, manipulate, re-encode application data before forwarding it to the server. 
### The Comparer
Used for comparing requests and responses.
Highlights differences between two blocks of text, can be used to see how different parameters give a different result. 
### Saving Burp Requests 
Its important to save these burp requests as they can be used in the future.
## Final Note
Take good notes on new features, misconfigurations, minor bugs, and suspicious endpoints so that we can go back to them quickly and use them in the future. 

## Burp Suite Training

### Application Mapping
Explore all features that can be accessed by an unauthenticated user, especially features that you yourself never use. 
Using test product `https://juice-shop.herokuapp.com`
Upon submitting a customer feed back review, burp intercepts a `GET` request for the captcha from the entry point `/rest/captcha`.

This info reveals the captcha along with the answer to the captcha.`
`{ "captchaId": 52, "captcha": "8*4*6", "answer": "192" }`.
`
if we wanted to automate making reviews we could use this end point.
We could collect the answer to the captcha and use it on the `POST` request entry point `/api/Feedbacks/` to submit in our feedback 

This is the information we are submitting:
`{ "captchaId": 52, "captcha": "192", "comment": "test", "rating": 3 }`.
### Parameter Tampering
Some questions we wanna ask ourselves:
- Can I replay this request? 
- Can I automate this request? 
- Can I automate the rating or author name of the comment? 

A properly implemented captcha should return an error and not work upon repeating the request however we are met with a `201` response, it was successful. 
Messing with other fields such as `rating` and setting it to `300` also results in successful responses. 
Changing the authors name in the `comment` field also grants a successful response.
### Finding Secrets
investigating the `GET` request `/rest/memories/` we find that for each image on the photo wall, the user object is included. 
We can find data such as the userID, username, email, hashed password, etc. 
Upon scrolling down we can find other user data for the other images.
This is a user enumeration problem. 
investigating the `GET` request `/api/Feedbacks/` from the about page, we can find the info for customer testimonials. 
Upon scrolling down we should see the false rating that we created previously. 
### Registration and Login Flow 
Approaches - try username enumeration, password spraying, SQL injection ** Homework
We want to map out the process of the registration process entirely. 
This process will likely create many requests, we will want to highlight the requests and separate them completely from the others we've looked at previously. 