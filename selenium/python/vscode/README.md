# A simple Selenium example with pytest

Commands used to bootstrap this project:

```bash
PROJECT_DIR="${HOME}/github/billagee/sandbox/selenium/python/vscode"
mkdir -p ${PROJECT_DIR}
cd ${PROJECT_DIR}
virtualenv -p python3.8 env
. env/bin/activate
pip install selenium pytest

mkdir ${PROJECT_DIR}/tests
```

Create the file `${PROJECT_DIR}/tests/test_sample.py` with these contents:

```python
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
```

Other prereqs:

- Install chromedriver and make sure it's in your PATH
- Open `$PROJECT_DIR` as a folder in VS Code
- Enable pytest support in VS Code:

    `View > Command Palette... > Python: Configure Tests > pytest > 'test' dir (or wherever you put test_sample.py)`

(For more detail on VS Code's built-in Python test support, see https://code.visualstudio.com/docs/python/testing#_enable-a-test-framework)

Once VS Code successfully completes test discovery in the given dir, you'll have several choices for how to launch and debug tests:

* The `Run Tests` button should be visible in the status bar
* Above each test method and test class, you should show the `Run Test | Debug Test` adornments
* In the VS Code Activity Bar, you should see the `Test` button, which opens the test explorer

To debug the test, set a breakpoint in the `test_one` method and click `Debug Test`.
