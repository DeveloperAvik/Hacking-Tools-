import subprocess

file_path = 'alive.txt' # enter here the file name where the file is ...

print("[+] Scanning with sqlmap  started ...")

try:
    with open(file_path, 'r') as file:
        subdomains = file.read().splitlines()

    for subdomain in subdomains:
        sqlmap_command = f"sqlmap -u {subdomain} --risk=3 --level=5 --random-agent"

        try:
            subprocess.run(sqlmap_command, shell=True, check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error running SQLMap for {subdomain}: {e}")

except FileNotFoundError:
    print(f"Error: File not found at {file_path}")
except Exception as ex:
    print(f"An unexpected error occurred: {ex}")
