#!/usr/bin/env python3

"""
Python 3 template file.
"""

from selenium import webdriver
from selenium.webdriver import Firefox
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.keys import Keys

from os import path, getcwd

class Patch:
    def __init__(self, link, name, author, date_str):
        self.link = link
        self.name = name
        self.author = author
        self.date_str = date_str
        self.src = None

    def get_description(self):
        return("{} by {}".format(self.name, self.author))
    
    def get_filename(self):
        return self.name.replace(" ", "_").replace("::", "_").replace("?", "") + '.sp'

    def get_prepared_source(self):
        source = ""
        source += '# "{}"\n'.format(self.name)
        source += '# {}, {}\n'.format(self.author, self.date_str)
        source += '# URL: {}\n'.format(self.link)
        source += '\n'
        source += self.src
        source += '\n'
        return source

def download_patch(url, headless=True):
    """
    Launches Firefox, extracts code of AudioMasher patch by URL,
    closes the browser and returns the contents.

    Args:
        url (string): patch page URL
        headless (boolean): makes browser headless if True

    Returns:
        string with DOM tree regarding the games
    """
    opts = Options()
    opts.headless = headless
    # Disable Selenium browser's cache
    profile = webdriver.FirefoxProfile()
    driver = webdriver.Firefox(profile, options=opts)
    # Launch browser with our url
    driver.get(url)
    # Extract textarea
    textarea = driver.find_element_by_css_selector("textarea#editor_area")
    code = textarea.get_attribute("value")
    driver.close()
    return code

def list_audiomasher_patches(url="https://audiomasher.org/browse", headless=True):
    """
    Launches Firefox, extracts an element innerHTML by a selector,
    closes the browser and returns the contents.

    Args:
        url (string): page URL
        headless (boolean): makes browser headless if True

    Returns:
        string with DOM tree regarding the games
    """
    opts = Options()
    opts.headless = headless
    # Disable Selenium browser's cache
    profile = webdriver.FirefoxProfile()
    driver = webdriver.Firefox(profile, options=opts)
    # Launch browser with our url
    driver.get(url)
    # Extract a list of A elements
    elements = driver.find_elements_by_css_selector(".middle_pane table tbody tr")
    patches = []
    for element in elements:
        try:
            link     = element.find_element_by_css_selector("td:first-child a").get_attribute('href')
            name     = element.find_element_by_css_selector("td:nth-child(1)").text
            author   = element.find_element_by_css_selector("td:nth-child(2)").text
            date_str = element.find_element_by_css_selector("td:nth-child(3)").text
            patch = Patch(link, name, author, date_str)
            patches.append(patch)
        except Exception as e:
            print(e)
    # Close a browser
    driver.close()
    return patches


def main():
    """
    Downloads all AudioMasher patches.
    """
    patches = list_audiomasher_patches()
    for patch in patches:
        patch.src = download_patch(patch.link)
        with open(path.join(getcwd(), 'archive', patch.author, patch.get_filename()), 'w') as patch_file:
            patch_file.write(patch.get_prepared_source())

if __name__ == '__main__':
    main()
