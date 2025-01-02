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
