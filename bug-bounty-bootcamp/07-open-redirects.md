Sites often use HTTP OR URL parameters to redirect users to a specified URL without any user action, an attacker can manipulate this to redirect the user to a malicious site.
## Mechanisms
Websites often need to do this, like a user trying to access a page that requires them to be logged in. 
They get redirected back to the login page or their previous location. 
Sites use aa URL parameter appended to the URL to keep track of the users original location, it determines where to redirect the users to after logging in. 
Its a feature that saves time and improves the user experience so you can find it implemented in many applications. 
The attacker tricks the user into visiting an external site by providing them a URL from the legitimate site but redirects to an outside domain. 

```php
https://example.com/login?redirect=https://attacker.com
```

A URL like this can trick victims into clicking a link they believe is the legitimate site but really redirects them to a harmful site. 
Another type of common attack is `referer-based open redirect`.
The `referer` is an HTTP request header that browsers automatically include, it tells the server where the request came from and its a common way of determining a users original location. 
Some sites will redirect to the page's referer URL after certain user actions, such as logging in or logging out. 
Attackers can host a site that links the victim to a site to set the referer header of the request like the following: 

```html
<html>
    <a href="https://example.com/login">Click here to login</a>
</html>
```

When a user click the link they are redirected to `https://example.com/login` that was specified in the `href` attribute. 
if that link uses a referer based redirect system, the users browser would redirect to the attackers site when clocked. 
## Prevention
The server needs to ensure it doesn't redirect users to malicious sites. 
Sites often implement URL validators to make sure the user provided redirect URL points to a legitimate location. 
Validators use either a blocklist or an allowlist. 
When implements a blocklist, it will check if the redirect URL contains certain indicators of malicious redirect and block the requests if they do. 
When implementing an allowlist it will check the hostname of the URL to make sure it matches a predetermined list of allowed hosts. 
If the hostname matches it goes though, else the server blocks the redirect. 
It sounds like a simple process but the parsing and decoding of a URL is difficult to get right, validators have a hard time identifying the hostname portion of the URL.
## Hunting For Open Redirects
There exists a few recon tricks to discover vulnerable endpoints and confirm the open redirect manually. 
#### Step 1: Look For Redirect Parameters
Start by searching for the parameters used in redirects.

```php
https://example.com/login?redirect=https://example.com/dashboard
https://example.com/login?redir=https://example.com/dashboard
https://example.com/login?next=https://example.com/dashboard
https://example.com/login?next=/dashboard
```

Have the proxy open while browsing the site, in the HTTP history look for any parameters that contain absolute or relative URLs. 
An absolute URL is complete and contains all the components necessary to locate the resource it points to like ` https://example.com/login`.
They contain at least the URL scheme, hostname, and path of a resource.
A relative URL must be concatenated with another URL by the server in order to be used. Contain only the path component of the URL like `/login`.
Not all redirect parameters have straightforward names like `redirect` or `redir`. 
Record all parameters that seem to be used for redirect regardless of the name. 
Take note of the pages that don't contain redirect parameters in their URLs but still automatically redirect their users.
These pages are candidates for `referer-based open redirects`. 
#### Step 2: Use Google Dorks To Find Additional Redirect Parameters
To look for redirect parameters on a target site start by setting the site search term to your target site: `site:example.com`.
Then look for pages that contain URLs in their URL parameters making use of `%3D`, the URL encoded version of `=`.
Doing this you can search for terms like `=http` and `=https` which are indicators of URLs in a parameter.
```php
inurl:%3Dhttp site:example.com
```

This search term might find pages like the following examples:

```php
https://example.com/login?next=https://example.com/dashboard
https://example.com/login?u=http://example.com/settings
```

You might also try using `%2F` which the URL encoded version of `/`.
You might find a term such as:

```php
https://example.com/login?n=/dashboard
```

You can also search for the names of common URL redirect parameters, here are a follow search terms likely to reveal parameters used for a redirect:

```php
inurl:redir site:example.com
inurl:redirect site:example.com
inurl:redirecturi site:example.com
inurl:redirect_uri site:example.com
inurl:redirecturl site:example.com
inurl:redirect_uri site:example.com
inurl:return site:example.com
inurl:returnurl site:example.com
inurl:relaystate site:example.com
inurl:forward site:example.com
inurl:forwardurl site:example.com
inurl:forward_url site:example.com
inurl:url site:example.com
inurl:uri site:example.com
inurl:dest site:example.com
inurl:destination site:example.com
inurl:next site:example.com
```

These search terms might let you find URLs such as

```php
https://example.com/logout?dest=/
https://example.com/login?RelayState=https://example.com/home
https://example.com/logout?forward=home
https://example.com/login?return=home/settings
```
#### Step 3: Test For Parameter-Based Open Redirects
Pay attention to the functionality of each redirect parameter you find, test each one for an open redirect.
Insert a random hostname or hostname you own into the redirect parameter and see if the site automatically redirects to the site you specified. 

```php
https://example.com/login?n=http://google.com
https://example.com/login?n=http://attacker.com
```

Some sites will redirect to the destination immediately after you visit the URL without any user interaction.
For lots of pages the redirect wont happen until after a user action like registration, login, or logouts. 
#### Step 4: Test For Referer-Based Open Redirects
Test for referer-based open redirects on any pages you found during step 1 that redirected users despite not containing a redirect URL parameter.
To test for them setup a page on a domain you own and host this HTML page: 

```html
<html>
	<a href="https://example.com/login">Click on this link!</a>
</html>
```

Replace the linked URL with the target page, then reload and visit your HTML page. 
Click the link and see if you get redirected to your site automatically or after the required user interactions. 
## Bypassing Open-Redirect Protection
Sites prevent open redirects by validating the URL used to redirect the user, they still exist because doing this is very difficult to get right. 
Here you can see the components of a URL, the way the browser redirects depends on how it differentiates between these components.

```php
scheme://userinfo@hostname:port/path?query#fragment
```

The URL validators needs to predict how the browser will redirect and reject URLs that result in a redirect offsite.
A browser redirects users to the location in the hostname of the URL, however URLs don't always follow the strict format shown in this example. 

```php
https://user:password:8080/example.com@attacker.com
```

When you visit a link you'll see that not all browsers handle it the same, sometimes validators don't account for all the edge cases that can cause the browser to behave in a way it shouldn't. 
Try to bypass protections using a few of the following strategies: 
#### Using Browser Autocorrect
Use the autocorrect features to construct alternative URLs that redirect offsite, modern browsers often autocorrect URLs that don't have the correct components. 
They do this to correct mangled URLs caused by user typos.
Chrome will interpret all of these URLs as pointing to `https://attacker.com`.

```php
https:attacker.com
https;attacker.com
https:\/\/attacker.com
https:/\/\attacker.com
```

These quriks can help you bypass URL validation based on a blocklist.
If the validator rejects any redirect containing the strings `https://` or `http://` you can use alternative strings like `https;` to achieve the same thing. 
Most modern browsers correct backslashes of `\` to `/`

```php
https:\\example.com
https://example.com
```

But if the validator doesn't recognize this behavior it can lead to inconsistencies 

```php
https://attacker.com\@example.com
```

Unless the validator treats the backslash as a path separator it will interpret the hostname to be `example.com` and treat `attacker.com/` as the username portion of the URL.
But if the browser autocorrects the backslash to a forward slash it will redirect the user `attacker.com` and treat `@example.com` as the path portion of the URL forming the following:

```php
https://attacker.com/@example.com
```
#### Exploiting Flawed Validator Logic
Exploit loopholes in the validators logic, they often checks if the redirect URL starts with, contains, or ends with the site's domain name.
You can bypass this by creating a subdomain or directory with the target's domain name: 

```php 
https://example.com/login?redir=http://example.com.attacker.com
https://example.com/login?redir=http://attacker.com/example.com
```

To prevent this a validator might accept only URLs that start and end with a domain listed on the allowlist, its possible to construct a URL that satisfies both of these rules. 

```php
https://example.com/login?redir=https://example.com.attacker.com/example.com
```

This URL redirects to `attacker.com` despite starting and ending with the target domain. 
The browser interprets the first `example.com` as the subdomain name and the second one as the file path. 
You can use the `@` symbol to make the first `example.com` the username portion of the URL: 

```php
https://example.com/login?redir=https://example.com@attacker.com/example.com
```

Custom-built URL validators are prone to attacks like these, developers don't consider all of the edge cases. 
#### Using Data URLs
You can also manipulate the scheme of the URL to trick the validator

```php
data:MEDIA_TYPE[;base64],DATA
```

You can send a plaintext message with the data scheme like this: 

```php 
data:text/plain,hello!
```

You can send base64-encoded messages as well

```php 
data:text/plain;base64,aGVsbG8h
```

You can use the `data:` scheme to construct a base64-encoded redirect URL that evades validators: 

```php
data:text/html;base64,
PHNjcmlwdD5sb2NhdGlvbj0iaHR0cHM6Ly9leGFtcGxlLmNvbSI8L3NjcmlwdD4=
```

The data encoded in this URL is the base64-encoded of the following script:

```php 
<script>location="https://example.com"</script>
```

This piece of code sets the location of the browser to `https://example.com` which forces the browser to redirect there. 
You can insert this data URL into the redirection parameter to bypass blocklists: 

```php
https://example.com/login?redir=data:text/html;base64,
PHNjcmlwdD5sb2NhdGlvbj0iaHR0cHM6Ly9leGFtcGxlLmNvbSI8L3NjcmlwdD4=
```
#### Exploiting URL Decoding
URLs sent over the internet can only contain ASCII characters, people encode characters by using URL encoding. 
Converts a character into a percentage sign `%` followed by two hex digits.
`%2f` is the URL encoded version of the slash `/`.
When a validator validates a URL or a browser redirects a user they have to find out what is in the URL by decoding any characters that are URL encoded. 
If there are any inconsistencies between how the validator and browser decodes URLs you can exploit it. 
###### Double Encoding
Try to double or triple encode a special character in your payload
Here's a URL with a URL-encoded slash:

```php
https://example.com%2f@attacker.com
```

Here's a URL with a double-URL-encoded slash:

```php
https://example.com%252f@attacker.com
```

Here's a URL with a triple-URL-encoded slash:

```php
https://example.com%25252f@attacker.com
```

Whenever a mismatch exists between how validator and the browser decode a character you can exploit the mismatch to induce an open redirect. 
If a validator doesn't double decode a URL but the browser does you can send a payload like this

```php
https://attacker.com%252f@example.com
```

The browser would redirect to `attacker.com` because `@example.com` becomes the path portion of the URL like this: 

```php
https://attacker.com/@example.com
```
###### Non-ASCII Characters
You can exploit inconsistencies in how validator and browser decode non-ASCII characters, lets say this URL has passed URL validation

```php
https://attacker.com%ff.example.com
```

`%ff` is the character `ÿ` which is a non-ASCII character.
The validator has determined that `example.com` is the domain name and `attacker.comÿ` is the subdomain.
Sometimes browsers will decode non-ASCII characters into question marks 
The previous example would become:

```php
https://attacker.com?.example.com
```

Another scenario is the browser will attempt to find a "most alike" character. 
if the character `╱` `(%E2%95%B1)` appears in a URL like this, the validator might determine that the hostname is `example.com`: 

```php
https://attacker.com╱.example.com
```

But the browser converts the slash look-alike character into an actual slash making `attacker.com` the hostname instead: 

```php
https://attacker.com/.example.com
```

Browsers normalize URLs this way often in an attempt to be user-friendly. 
Use the Unicode chart to find look-alike characters and insert them in URLs to bypass filters. 
The `Cyrillic` character set is especially useful since it contains many characters similar to ASCII characters. 
#### Combining Exploit Techniques
To defeat more sophisticated URL validators combine multiple strategies to bypass layered defenses like the following payload: 

```php
https://example.com%252f@attacker.com/example.com
```

This URL bypasses protection that checks only that the URL contains starts with or ends with an allowlisted hostname by making the URL both start and end with `example.com`. 
Most browsers will interpret `example.com%252f` as the username of the URL. 
But if the validator over-decodes the URL, it will confuse `example.com` as the hostname portion.

```php
https://example.com/@attacker.com/example.com
```

You can use many more methods to defeat URL validators. 
Experiment with URLs to invent new ways of bypassing URL validators. 
## Escalating The Attack
Attackers could use open redirects by themselves to make their phising attacks more credible.
They could host a fake login page on a malicious site that mirrors the legitimate sites login page and promp the user to login again with a message like this one:

```
Sorry! The password you provided was incorrect. Please enter
your username and password again.
```

Believing they entered the wrong password they would provide their login to the attackers site. 
Open redirects can help you maximize the impact of vulnerabilities like server-side request forgery (SSRF). 
They can also be used to steal credentials and OAuth tokens. 
## Finding Your First Open Redirect

1. Search for redirect URL parameters, they might be vulnerable to parameter-based open redirect.
2. Search for pages that perform referer-based redirects, candidates for referer-based open redirect. 
3. Test the pages and parameters you found for open redirects. 
4. If the server blocks the open redirect try the protection bypass techniques. 
5. Brainstorm ways of using the open redirect in your other bug chains. 