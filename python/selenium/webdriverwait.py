#!/usr/bin/env python

from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait

driver = webdriver.Chrome()
driver.get("http://www.google.com/")

WebDriverWait(driver, 2).until(
        lambda d: u"google.com" in d.current_url)
