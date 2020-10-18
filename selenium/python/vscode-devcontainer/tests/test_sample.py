import pytest
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

@pytest.fixture(scope="function")
def chrome():
    driver = webdriver.Remote(
        command_executor='http://selenium-server:24444/wd/hub',
        desired_capabilities=DesiredCapabilities.CHROME)
    yield driver
    driver.quit()

class TestClass:
    def test_one(self, chrome):
        chrome.get("https://selenium.dev/")
        assert "selenium" in chrome.current_url
