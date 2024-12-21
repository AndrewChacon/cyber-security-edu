## Writing A Good Report
A bug bounty hunter's job isn't just finding bugs but also explaining them well.
Writing a report that helps them fix the issue fast and easy. 
### Step 1: Craft A Descriptive Title
Aim for a title that sums up the issue in one sentence.
This will help the security team immediately get an idea of what the issue is and its potential for severity.
Your title should answer:
- What vulnerability did you find?
- Is it a well known type of bug such as IDOR or XSS?
- Where did you find it in the application?
Example: `IDOR on https:///example.com/change_password Leads to Account Takeover for All Users`
Your goal is to give the security team a good idea about what they're getting into 
### Step 2: Provide A Clear Summary 
Include all relevant details that couldn't be communicated in the title such as HTTP request parameters used in the attack, how you found it, etc.
A good report is clear and concise, contains all info needed to understand the bug including what type of bug it is, where it was found, and what an attacker can do with it.
This is an example of an effective report summary:

The `https://example.com/change_password` endpoint takes two POST body parameters:
`user_id` and `new_password`.
A POST request to this endpoint would change the password of `user_id` to `new_password`.
This endpoint is not validating the `user_id` param, and as a result any user can change anyones password by manipulating the `user_id` param. 
### Step 3: Include A Severity Assessment
your report should include an honest assessment of the bug's severity.
Severity assessment helps teams prioritize which bugs need fixing right away.
Use the following to communicate severity:
##### Low Severity
The bug doesn't have much potential for causing damage. 
##### Medium Severity
The bug impacts users or the company in a moderate way such as cross-site forgery on a password change. 
##### High Severity
This bug impacts a large number of users and the consequences can be disastrous.
These should be fixed immediately, for example an open redirect that can be used to steal OAuth tokens.
##### Critical Severity
This bug impacts a majority of users and endangers the companies core infrastructure.
For example an SQL injection that lets an attacker execute code remotely on production server.

Providing an accurate assessment of the severity will make everyones lives easier and create a good relationship between you and the team.
### Step 4: Give Clear Steps To Reproduce
Provide step by step instructions for how to reproduce this bug and include all relevant step up prerequisites and details you can think of.
Assume the engineer has no knowledge of the bug and doesn't know how the app works. 
Ensure the steps are comprehensive and explicit, by providing all necessary details you can avoid misunderstandings and speed up the process for them to fix it. 
### Step 5: Provide A Proof Of Concept
For simple vulnerabilities steps to reproduce are enough but more complex bugs require a POC
also known as proof of concept, these kinds of files include videos, screenshots, or photos documenting the findings of your exploit.
A video walk through might be necessary for bugs that require complex and various steps.
These will save the security team time on fixing the vulnerability.
### Step 6: Describe The Impact And Attack Scenarios
Illustrate a real world scenario in which the bug can be exploited.
Severity assessment describes the severity of the attack and the consequences that can result from an attacker exploiting this bug.
Our goal instead for this section is to explain what those consequences would actually look like.
Put yourself in the attackers shoes and try to escalate the impact of the bug.
Give the client company a realistic sense of the worst case scenario. 
A good impact section illustrates how an attacker can exploit a bug.
### Step 7: Recommend Possible Mitigations
If possible you can make recommendations to mitigate the bug since your the researcher that found the bug your in a good position to recommend a fix.
If you don't know what caused the bug the stay away from making fix recommendations as you will only confuse your reader.
Some teams will have a understanding of how to fix these issues and have a process for how to mitigate similar problems already. 
### Step 8: Validate The Report
Go through your report one last time, follow all your steps to reproduce to ensure information is concise.
Double check POC files to see if they are in fact valid and accurate.
This process will help you minimize the chance of your report being dismissed as invalid.
### Additional Tips For Writing Better Reports
##### Don't Assume Anything
Remember that you might have been working on a vulnerability for a week but for the team getting the report this is all new info for them.
Help them understand what you discovered.
##### Be Clear And Concise
Don't include any unnecessary information.
A security report is a business document not a letter to a friend.
Make it as short as possible without omitting any details. 
##### Write What You Want To Read
Always put your reader in mind when writing, try and build a good reading experience for them.
##### Be Professional
Always communicate with the security team in a respectful and professional manner. 
Provide clarifications of the report patiently and promptly. 
## Building A Relationship With A Developer Team
You should help the company fix the issue and make sure the bug gets patched.
Building a strong relationship with a security team will make resolving bugs go quicker and smoother.
Some hunters have even been made job offers by companies or interviews from top tech firms because of their work finding bugs. 
### Understanding Report States
once a report is submitted the security team will classify it into a report state, which is the current status of your report. 
##### Need More Information
A common state report meaning the team didn't fully understand what you submitted and require additional info or clarification. 
##### Informative
This means the team sees the concern but it doesn't warrant a fix. 
Nothing more will done with the report.
##### Duplicate
Another hacker has already found the bug, the issue has already been discovered. 
Duplicates do not get a payout, first come first serve. 
##### N/A
Your report does not contain a valid security issue.
##### Triaged
The report has been accepted and you'll get a payout.
Help them fix the bug by answering any follow up questions. 
##### Resolved
The report vulnerability has been fixed. 
### Dealing With Conflict
its important to handle these conflicts respectfully and professionally this is your career and reputation thats on the line.
Explain why the bug is an issue if it has been dismissed, ask for mediation by the bug bounty platform or other security engineers on the team.
Explain some potential attack scenarios to illustrate the impact.
Never ask for more money without an explanation.
In the end respect the final decision about the fix and bounty amount.
### Building Partnership
Strive for a long term partnership with organizations after your findings.
Respect their time and communicate professionally. 
Customize your reports to the companies practices and culture. 
Never bail on the team after triage, always lend them extra support if they request after.
### Understanding Why Your Failing

#### Why Your Not Finding Bugs
These are some possible reasons.
##### You Participate In The Wrong Programs
All programs are different, some downplay the severity of the bug to reduce payout amounts. 
Some restrict their scope to a small subset of their assets.
Do your research on their publicly disclosed reports. 
##### You Don't Stick To A Program
Don't jump from program to program is a big mistake beginners make. 
Differentiate yourself from the rest of the competition. 
Dig deep into a single functionality of the app to search of complex bugs.
Or discover and hack lesser known assets of the company.
##### You Don't Recon
Do your research on the target, discover new attack surfaces like new subdomains, new endpoints, and new functionality.
You'll be the first to notice these bugs on obscure assets giving you a better chance of avoiding duplicates. 
##### You Only Go For Low Hanging Fruit 
Companies and other hackers already use vulnerability scanners.
Avoid looking for obvious bug types they've most likely been found already. 
Aim to get a deeper understanding of the apps architecture and logic.
##### You Don't Get Into Private Programs
It becomes easier to find bugs after getting invited to private groups.
You face a lot less competition and fewer duplicates. 
#### Why Your Reports Get Dismissed
##### You Don't Read The Bounty Policy
One of the most common reasons reports get marked as N/A is because the report is on a bug that is out of scope. 
Meaning your not allowed to report on it, the company clearly states which assets and in and out of scope to be worked on.
Respect the companies bounties and don't report on out of scope issues.
##### Put Yourself In The Organizations Shoes
Put yourself in the engineers shoes, they have to protect users and prioritize the bugs that put them most at risk. 
Fixing low severity bugs might be at the bottom of their list. 
Do your research and determine whats most important to the company, what they value most.
Different companies have different prioritizes, customization to client needs is essential. 
##### You Don't Chain Bugs
You might be reporting the first bug you find.
Smaller bugs can become bigger issues if you chain them together. 
For example don't report an open redirect, use it in a server side request forgery attack. 
##### You Write Bad Reports
You failed to communicate the bug in your report and its impact. 
##### What About Duplicates
This is unavoidable it happens, preform recon and develop a unique bug hunting methodology. 
## What To Do When Your Stuck 
### Step 1: Take A Break
Take a break from the process to refresh your mind. 
Hunting for bugs is tedious and difficult, let your mind rest and come back to it.
### Step 2: Build Your Skill Set
Hackers get too comfortable using the same techniques.
Learn new skills to push yourself out of your comfort zone and strengthen your skills.
OWASP (open web application security project) publishes best practices and guides.
Learn a new skill, read about it and apply it to a new attack. 
Read up on hacker blogs to see what other hackers are doing and get a new perspective on approaches you should take. 
Play capture the flags, they are a great way to learn about new vulnerabilities. 
### Step 3: Gain A Fresh Perspective
Diversify your targets, if you get bored you can switch to a different application and later come back to the original with a possible new perspective. 
Look for specific things in an app, avoid wandering aimlessly looking for something. 
Make a list of new skills you acquired and try them out on the target. 
Look for weird behaviors instead of vulnerabilities, see if you can chain it into something.
