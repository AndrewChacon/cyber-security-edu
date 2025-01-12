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
We have a route called `/api/SecurityQuestions/` which show us a list of json questions the app gave us as an option for a security question to select. 
In the route `/api/Users`
The route `/api/SecurityAnswers/` shows us our userid along with the id for the question we selected and the answer we provided for it, in the response its encrypted. 
**HOMEWORK - play around with values in users route response**

### Analyzing JWT Tokens
`/rest/user/login/` provides us with an authentication token JWT base64 encoded
we can copy it and use the decoder in burp to read the contents. 
It contains our password hash which is not a good practice. 
**DO HEAVY RESEARCH INTO JWT**
`/api/BasketItems/` item gets added to our basket.
It contains the productID, basketID, and quantity number. 
the following http response contains all the info on the added product. 
Finally it re-gets our basket info again.

### Exploiting IDOR
`GET /rest/basket/6 HTTP/1.1` what happens if I change the `6` into a `5` ???
Upon making this change in the repeater and sending the new request, we see the info for a cart that belongs to a completely different user. 
The user and items in the cart are different from the data from our profile. 
**WHAT IS IDOR**

### Advanced Intruder Settings
Were going to send this to the intruder to attempt to automate and exploit this endpoint. 
We automate from userid 0 to 10, with a step of 1.
The program shows us 10 responses with cart data from different users. 
Using grep extract we can specify what specific data to pull out, we now have compiled a list of userid's from this automated attack

On the `/api/Products/#` route we were able to automate the first 50 products in the intruder to extract the name, description, and price of each product from the attack. 

### Finding Logic Flaws
We want to map out steps of a process, then ask ourselves if there is a way to skip steps in the logic to get to where we want with fewer restrictions. 

Mapping out steps to purchasing an item:
1. add item to basket
2. step 2 change quantity of item in basket
3. checkout with credit card and address 
4. approve the purchase
