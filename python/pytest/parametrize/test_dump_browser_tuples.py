import pytest

@pytest.mark.parametrize("platform,browserName", [
    ("Mac OS X 10.9", "chrome"),
    ("Linux", "chrome"),
    ("Windows 8.1", "chrome"),
])
def test_print_browsers(platform, browserName):
    print("%s, %s" % (platform, browserName))

