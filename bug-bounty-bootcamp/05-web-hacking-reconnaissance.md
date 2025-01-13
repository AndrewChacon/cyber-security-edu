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
OWASP Zed Attack Proxy (ZAP) includes a built in web crawler, also includes a scanner, proxy, and many other features.

### Third-Party Hosting
### Github Recon
## Other Sneaky OSINT Techniques
## Tech Stack Finger Printing
## Writing Your Own Recon Scripts
### Understanding Bash Scripting Basics
### Saving Tool Output To A File
### Adding The Date Of The Scan To The Output 
### Adding Options To Choose The Tools To Run
### Running Additional Tools
### Parsing The Results
### Building A Master Report
### Scanning Multiple Domains
### Writing A Function Library
### Building Interactive Programs
### Using Special Variables And Characters
### Scheduling Automatic Scans
## A Note On Recon APIs
## Start Hacking
## Tools Mentioned
### Scope Discovery
### OSINT
### Tech Stack Fingerprinting
### Automation
