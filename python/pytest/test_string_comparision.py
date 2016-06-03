import pytest

# Run with:
# py.test test_string_comparision.py

def test_string_comparison():
    str1 = u"Hello from the left hand side!"
    str2 = u"Hello from the right hand side!"
    assert str1 == str2
