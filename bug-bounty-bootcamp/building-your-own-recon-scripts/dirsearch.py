import requests
import sys

def dirsearch(url):
    # Example wordlist (you can replace this with a larger file or pass it in dynamically)
    wordlist = [
        ".htaccessOLD2", ".htaccessOLD", ".svn", ".svn/all-wcprops", 
        ".svn/entries", ".svn/prop-base/", ".svn/pristine/", 
        ".svn/text-base/index.php.svn-base", ".svn/text-base/", 
        ".svn/props/", ".svn/tmp/", "images", "index", "index.html", 
        "server-status/", "server-status", "shared"
    ]

    extensions = ["php"]
    method = "get"
    print(f"Extensions: {', '.join(extensions)} | HTTP method: {method.upper()} | Wordlist size: {len(wordlist)}")
    print(f"Target: {url}\n")

    print("[Starting:]")
    
    # Iterate through wordlist and extensions
    for word in wordlist:
        for ext in extensions:
            path = f"{word}.{ext}" if ext else word
            full_url = f"{url}/{path}"
            print(f"Testing: {full_url}")  # Debug: print URL being tested
            
            try:
                response = requests.get(full_url, timeout=5)
                size = len(response.content)
                status = response.status_code
                if status in [200, 301, 403]:
                    redirect = f" -> {response.headers.get('Location', '')}" if status == 301 else ""
                    print(f"[{status}] - {size}B - /{path}{redirect}")
            except requests.RequestException as e:
                print(f"[ERROR] - Could not request {full_url}: {e}")

    print("\nTask Completed")

if __name__ == "__main__":

    target_url = "http://" + sys.argv[1]
    dirsearch(target_url)
