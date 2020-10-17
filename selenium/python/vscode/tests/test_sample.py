import pytest

@pytest.fixture
def chrome():
    from selenium import webdriver
    return webdriver.Chrome()

class TestClass:
    def test_one(self, chrome):
        chrome.get("https://selenium.dev/")
        assert True
        assert "selenium" in chrome.current_url
