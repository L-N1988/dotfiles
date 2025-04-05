import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin
import os, sys

def download_pdfs(url, download_folder='pdfs'):
    # Create download folder if it doesn't exist
    if not os.path.exists(download_folder):
        os.makedirs(download_folder)

    # Get webpage content
    try:
        response = requests.get(url)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')

        # Find all PDF links
        pdf_links = []
        for link in soup.find_all('a'):
            if link.get('onclick') is not None:
                href = link.get('onclick').split("'")[-2]  # Gets pdf name
                if href.lower().endswith('.pdf'):
                    pdf_links.append(urljoin(url, href))

        # Download each PDF
        for pdf_url in pdf_links:
            filename = os.path.join(download_folder, pdf_url.split('/')[-1])
            print(f'Downloading: {pdf_url}')

            pdf_response = requests.get(pdf_url)
            with open(filename, 'wb') as f:
                f.write(pdf_response.content)

        print(f'\nDownloaded {len(pdf_links)} PDFs to {download_folder}/')

    except Exception as e:
        print(f'An error occurred: {e}')

# Example usage
# download_pdfs('https://example.com/documents/')
if len(sys.argv) == 1:
    print("Usage: download_pdfs url [folder]")
elif len(sys.argv) == 2:
    download_pdfs(sys.argv[1])
else:
    download_pdfs(sys.argv[1], sys.argv[2])
