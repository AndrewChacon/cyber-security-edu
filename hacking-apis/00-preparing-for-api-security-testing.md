API penetration testing is a field of its own due to how large and complex the attack surface.
A well developed scope of what features and targets you will test so there is a mutual understanding of the work being done between the client and tester.

### Receiving Authorization
its important that before any attack is made there is a contract providing details of what is being tested and under what time frame.
For API pen testing a contract can take the form of an SOW (signed statement of work).

Ensure the representative of the client has the authority to approve these tests. 
Ensure the assets being tested are also owned by the client. 
Communicate with your client the benefits of having less restrictions to work with, real criminals have no scope or limitations when attacking.

### Threat Modeling an API Test
This is the process of mapping out the threats to an API provider.
Modeling based on relevant threats allows you to choose tools and techniques directed at specific attacks. 

A threat actor can be:
- random people - somebody that stumbled upon the API and doesn't know much about it 
- customers - a legitimate user who uses the application but tries to misuse it 
- rouge partners - a business partner who abuses their access to the system
- insiders - an employee who knows a lot about the system and tries to exploit it

Your testing methods should follow the profile of the thread actor and their perspective on how they will try to attack the API

#### Three basic penetration testing approaches:
- Black Box: someone who stumbled across the API, they have know information about their attack surface to the tester. Gathering intel using OSINT (open-source intelligence) to learn as much about the target as possible. Finding out the attack surface from search engine research, social media, public financial records, DNS information. Compile a list of target IP addresses, URLs, and API end points you can present the client for review. 
- Gray Box: invests a majority of time on active testing, playing the role of a more well informed threat actor. Provided info within targets scope along with access to API documentation and perhaps a basic user account. Bug Bounty programs often fall in the scope of gray box. 
- White Box: client discloses as much info as they can along with inner workings of their environment, access to application source code, design info, and SDK (software development kit). this models the attack of an insider, someone who knows the inner workings very well. The more information you have the more thoroughly the target will be tested. 

work with the client to figure out where the attack is most likely to come from and model for that scenario, craft a realistic threat for the client. 
Survey the client of their practices and business scope to look for what would motivate an attack. MITRE Att&CK.
The remaining scoping items are relevant for gray box and white box testing. 

### Which API Features You Should Test
Discover how many unique API endpoints, methods, versions, features, authentication and authorization mechanisms, and privilege levels you'll need to test.
Review relevant API documentation and access to API collections.
With this information you can estimate how many hours it would take to effectively test the clients APIs.
#### API Authenticated Testing
Testing authentication and authorization.
Test different users and roles to see if there are vulnerabilities present in any of the different privilege layers.
#### Web Application Firewalls
also known as WAFs, common defense system for web applications and APIs.
This is a device that controls the network traffic that reaches the API.
Strong in limiting unexpected requests and stopping an API security test. 
A good fire wall will detect frequency of of requests or request failures and ban the device your using to do security tests. 
A layered cybersecurity defense is key to effectively protecting organizations, no one should put all their eggs into the WAF basket. 
Given enough time a persistent attacker could learn the boundaries of the wall to bypass it or use a zero-day vulnerability that renders it irrelevant. 
Make sure your testing the APIs security controls not the WAF of the API. 
###### Zero-Day Vulnerability
A security flaw in software or hardware unknown to the people responsible for fixing it, there is "zero-days" of warning to fix it before it can be exploited. 
Able to cause significant damage before it can be detected, once found theres a rush to fix it but before the fix the system remains exposed. 
#### Mobile Application Testing
a mobile applications expands the attack surface of the client, they often rely on APIs to transmit data within the application. 
Can be tested through:
- Manual code review: accessing the mobile apps source code and searching for potential vulnerabilities.
- Automated source code analysis: uses automated tools to search for vulnerabilities and other potential exploits.
- Dynamic analysis: testing the app while its running like intercepting clients api requests and server responses to attempt to find a weakness
#### Auditing API Documentation
 manual for how to use the api and includes authentication requirements for users, usage, and API endpoint information.
 Without effective documentation a service system would have to rely on training their customers.
 Issues can arise in documentation such as inaccuracies, outdated info, and info disclosure of vulnerabilities.
 as a hacker you should study the documentation and use it effectively to your advantage.
#### Rate Limit Testing
A restriction of the number of requests that can be made to an API service within a specified time frame. The enforcement can be found in either the providers web servers, firewall, or web app firewall.
Allows for monetization of APIs and prevents overconsumption of resources.
Different business models for the api such as free trial with limits to number of requests and or requests in a given time frame or a paid model where the user has a lot more access to the API's services.
Rate limit testing is not the same as DoS (denial of service) testing.
DoS consists of attacks made to halt the providers services to make them unavailable to users. 
Rate limit test would not halt all services but it could be helpful in larger scale attacks, shows weaknesses in how an organization would monetize their API.
If bypassed the provider would incur additional costs from usage and lose out on revenue. 

### Restrictions and Exclusions
unless specified, you should not jump the gun to testing DoS attacks. 
As well as penetration testing and social engineering are kept as separate exercises from API testing. 
Always double check if social engineering can be used on the client.
No bug bounty program accepts attacks such as social engineering, DoS, DDoS, attack of customers, or accessing customer data. 
In scenarios of customer attacks, programs normally suggest creating multiple accounts and and test by attacking your own test accounts.  
Some potential issues might be kept as a convenience feature and do not require to be tested. 
Its important to be very aware of any exclusions or restrictions with the client in the contract. The program may allow for testing specific sections of the API and restrict other paths within it. Services such as Banks for example. 

#### Security Testing Cloud APIs 
many modern web apps are hosted in the cloud so when attacking a cloud hosted web app your attacking the physical servers of the cloud provider.
Each cloud provider has its own set of penetration testing terms and guide lines that you'll need to follow. 
Some cloud hosted web apps and API's will require testing authorization from an organizations SalesForce API.

##### Amazon Web Services
Testing such as DNS zone walking, Dos, DDoS, simulated Dos or DDoS, port flooding, protocol flooding and request flooding require you to request for permission. Make sure to include testing data, accounts and assets involved, phone number, and description of proposed attack.
##### Google Cloud Platform
Requesting permission or notifying is not required to perform penetration testing, however you must remain compliant of its AUP (acceptable use policy) and TOS (terms of service). Prohibit illegal actions, phishing, spam distribution of malicious files such as viruses, and interruption of GCP (google cloud platform) services. 
##### Microsoft Azure
Specify exactly what sort of penetration testing is allowed under its "Penetration Testing Rules of Engagement" page.
They have more hacker-friendly approach not requiring you to notify them before engaging in a penetration test.

#### DoS Testing
these kinds of tests and usually not desired clients, work with them and only engage in this type of attack if they are confident about their infrastructure and they are willing to take the risk. 
Otherwise with them to figure out what they are willing to allow. 
DoS is a huge threat against the security of API's, an unplanned business interruption like this is a triggering factor that might result in the organization pursuing legal recourse. 
Hence why these types of attacks should not be conducted until a very in-depth conversation with the client is made before hand explaining the risks. 

### Reporting and Remediation Testing
The most valuable aspect of the API testing you conduct on a clients API is the report you submit communicating what you find out about the effectiveness of their API security controls.
The report should include the vulnerabilities discovered by these tests and the explain wha they can do to improve their security.
Check if the client would like to retest all of the specified vulnerabilities after security improvements are made from the initial report. 
Retesting might only include the weakest points or it could be a full retest.