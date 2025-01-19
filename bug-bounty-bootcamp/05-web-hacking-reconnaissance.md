Good recon skills is what separates a good hacker from an ineffective one.
## Manually Walking Through The Target
Try to uncover every feature in the app that the user can access by browsing through its pages and investigating links, access functionalities you don't typically use. 
Sign up for accounts at every privilege level, be able to see what the app looks like from the perspective of different level users. 
This will help give you a rough understand of the attack surface of the application, which is all of the different points an attacker can try and gain entry. 
Afterwards we can go more in-depth to find out the structure of the app and what kinds of technologies they used to build it. 
## Google Dorking
Advanced search engine skills to help you find resources more efficiently.
Hackers often use these for recon, called Google Dorking.
Google can be a powerful tool used for finding info such as hidden portals and password files.
The search engine has a query engine built in for more optimized searches.
###### Site 
Shows results for a specific website only, help you find the most reputable sources.
Search: `print site: python.org`.
###### inurl
Searches for pages with a URL that matches the search string.
searching `inurl:"/course/jumpto.php" site:example.com`.
###### intitle
Finds specific strings in a pages title, pages that contain a particular type of content.
`intitle: "index of" site:example.com`.
###### link
Searches web pages that contain links to a specified URL.
`link:"https://en.wikipedia.org/wiki/ReDoS`.
###### filetype
Searches pages with a specific file extension, local files on their targets sites that might contain sensitive data such as log files and password files.
`filetype:log site:example.com`.
###### Wildcard
`(*)` within searches means any character or series of characters. 
`"how to hack * using Google"`.
###### Quotes
Forces an exact match for what you want to search.
`"how to hack"`.
###### Or
`(|)` allows you to search one search term or more at the same time.
`"how to hack" site:(reddit.com | stackoverflow.com)`
###### Minus
`(-)` this excludes certain search results.
"how to hack websites" -php

You can search google search operators to discover more efficient search methods.
As an example, this query lets you look at all company sub domains:
`site:*.example.com`.

`site:example.com inurl:app/kibana`.

This query searches the site `example.com` for text files that contain `password`:
`site:example.com ext:txt password`.

Google Hacking Database, a website that hackers use to share google search queries for finding security related information.
## Scope Discovery
First verify the targets scope, a companies scope policy specifies which subdomains, products and applications your allowed to attack. 
### WHOIS And Reverse WHOIS
When a domain is registered info must be provided such as addresses, phone numbers, and email addresses to the domain registrar.
Using the `whois` command we can query this information to search for the owners, 
as well as discover more information about the domain. 
`$ whois facebook.com`
Sometimes this info is not always available, companies will use a service called `domain privacy` which is a 3rd party service that changes that info to forwarding info. 
One could then conduct a `reverse WHOIS search` which means searching a database by using an organizations name, phone number, or email address to find domains registered to it. 
Doing this allows you to find all domains that belong to the same owner, very useful for finding hidden and obscure domains not disclosed to the public. 
Pubic reverse search tool `ViewDNS.info https://viewdns.info/reversewhois/`.
### IP Address
Another way of finding your targets top-level domains is to locate IP addresses.
`nslookup facebook.com`.
Once you've found the IP address its time to perform a reverse IP look up, this will search for domains hosted on the same server. 
Run the `whois` command on the IP to see if the target has a dedicated IP range.
An IP range is a block of IP addresses that all belong to the same organization, any IP that is found inside of this range by default belongs to the organization. 

Another way of finding IP addresses in scope is by looking at autonomous systems which are routable networks within the public internet.
Autonomous system numbers (ASNs) identify the owner of these networks. 
You can compare two IP addresses and determine if they belong to the same owner. 
The `-h` flag for the `whois` command sets the WHOIS server to retrieve info from the site, translates the IPs to ASNs. 
### Certificate Parsing
Take advantage of the Secure Socket Layer (SSL) certificates used to encrypt web traffic.
An SSL has a subject alternative name which lets authorized users specify additional hostnames that use the same certificate.
Find those hostnames by parsing this field.
### Subdomain Enumeration
After finding as many domains as possible, find as many sub domains as you can.
Each sub domain serves as a possible entry for attack, you find them using automation. 
There exists many tools that help you automate for sub domains with a variety of word lists. 
You can source good wordlists online and there exists services for it too. 
Look for sub domains inside of sub domains as well, run enumeration tools recursively. 
### Service Enumeration
Enumerate the services hosted on the machines you found. 
You can do this by port scanning the machine with active or passive scanning.
Active scanning sends requests to connect to the machines ports to look for any openings, you can use Nmap for this. 
Passive scanning uses 3rd party resources like `Shodan` which is a search engine that finds machines connected to the internet. This helps attackers avoid detection. 
### Directory Brute-Forcing
Brute forcing the directory, you can find things like hidden files, admin portals, database copies.
You might even be able to take over the server directly. 
You can learn about the structure and technology of the application by looking for files. 
### Spidering The Site
Web spidering or web crawling, a process used to identify all pages on a site. 
This type of tool starts with a website and identifies all the URLs embedded in it then tries to visit them, you can uncover many hidden entry points. 
OWASP Zap Attack Proxy (ZAP) includes a built in web crawler, also includes a scanner, proxy, and many other features.

Under *TOOLS* and *Spidering* we can access the web crawler tool in OWASP ZAP
We can enter our starting point such as `https://www.google.com`.
On the left side of the tool we can find a tree of files and directories found on the target server, displayed in an organized format. 

What is OWASP ZAP?
it is a penetration testing tool used for detecting vulnerabilities in web applications. 
It intercepts requests and responses between the client and the server. 
Vulnerabilities such as SQL injection, Cross-site scripting, broken auth, and cross-site forgery.

Automated Scan - provide URL for website you want to spider.
It is discovering all files, scripts, directories, etc of the website, once we have gathered this data of directories, we can find possible areas to attack. 
Spidering is completed, which means we have found all of the assets and resources. 
Now we conduct an active scan, the payloads are injected into the website. 
The alert page can show us some possible vulnerabilities it has detected with info. 
### Third-Party Hosting
S3 Simple Storage, keeping resources in buckets to serve in a companies web application.
You can find hidden endpoints, logs, credentials, user information, source code, etc. 
Most buckets use the URL format `BUCKET.s3.amazonaws.com` or `s3.amazonaws.com/BUCKET`.
`site:s3.amazonaws.com COMPANY_NAME`.
`site:amazonaws.com COMPANY_NAME`.

if a company uses custom URLs for its s3 buckets use more flexible search terms.
they still often use common keywords that aren't too difficult to find. 

```
amazonaws s3 COMPANY_NAME
amazonaws bucket COMPANY_NAME
amazonaws COMPANY_NAME
s3 COMPANY_NAME
```

another way is to search a companies public Github repositories for s3 URLs
`GrayhatWarefare` is a search engine that helps you look for publicly exposed s3 buckets. 

Finally, our last approach is to brute force buckets by using lists of keywords. 
`Bucket Strem` is a program that parses certificates that belong to organizations and finds s3 buckets based on permutations of the domain names found on the certificates. 
It will also automatically check if you can access the bucket or not, saves us time.

install and configure the `aswcli` tool on the AWS terminal and configure it to work with AWS documentation, run `pip3 install awscli`.
Try listing the contents of the bucket: `aws s3 ls s3://BUCKET_NAME/`.
copy its files to your local machine to investigate any useful files that might be present. 
`aws s3 cp s3://BUCKET_NAME/FILE_NAME/path/to/local/directory`.
### Github Recon
Search an organizations repos for any resources that might have been pushed by accident, sensitive data, or any information that might lead to discovering a vulnerability. 
Start by finding Github usernames that are relevant to the target, find this by searching an organizations name or product names in the Github search bar.
When you dive into the code look at the issues and commits sections, you can find data such as unresolved bugs, problematic code, and most recent code fixes and security patches. 
Search for hardcoded secrets such as API keys, encryption keys, and database passwords. 
Search for keywords such as `key, secret, password` to look for credentials. 
You can use a tool called `KeyHacks` to check if found credentials are useable or not. 
check if the source code deals with any important functionality such as authentication, password reset, state changing actions, or private info reads. 
Pay attention to code that deals with user input such as HTTP request parameters, HTTP headers, HTTP request paths, database entries, read and or uploads of files, these serve as possible points of entry for attacks. 
Pay attention to dependencies and imports being used, some might be outdated. 
Tools such as `Gitrob` and `TruffleHog` can automate this recon process. 
## Other Sneaky OSINT Techniques
Check the company's job postings, you can learn about their technology stack by viewing what skills they are asking for and what their current employees know. 
Check their Linkedin, stack overflow, Quora, etc.
Use the wayback machine to check old records of the organizations website, you might find potential entries such as links or sub domains that have since then been forgotten. 
## Tech Stack Fingerprinting
Fingerprinting is identifying the software brands and versions that a machine app is using. 
You can easily find publicly disclosed vulnerabilities for a particular version of it. 
They are referred to as Common Vulnerabilities and Exposures (CVEs).
The simplest way to go about it is to interact with the application directly.
Run an N-map scan on the machine wit the -sV flag to enable version detection.

Then in Burp we send an HTTP request to the server to check the HTTP headers, we use this information to gain insight on the tech stack they are using. 
We don't know what info might leak for attempting this but its worth conducting this test. 

HTTP headers like `Server` and `X-Powered-By` are good indicators of technologies. 
`Server` header reveals the software versions running, `Xpowered-By` reveals the server or scripting language used. 
There also exists many technology specific headers for example, you can only find `X-Generator` and `X-Drupal-Cache` related to Drupal. 
Technology specific cookies such as `PHPSESSID` gives us a clue that this is PHP related.
Many web frameworks or other technologies will embed a signature into the code. 
Click on `View Source Code` and search for phrases such as `powered by, built with, and running`. 
We can see something like `Powered by: WordPress 3.3.2` written into the source code. 
Check for technology specific file extensions, filenames, folders, and directories. 
