# Debugging Selenium tests in a VS Code dev container

Setup steps:

1. Open this dir in VS Code
1. Click `Reopen in Container` button if it's displayed in the lower right of the window

    - Note: If that button isn't shown, use `View > Command Palette... > Remote-Containers: Reopen in Container`

1. You should now be able to edit files in the project inside the `selenium-client` container.
1. Once VS Code successfully completes test discovery in the `tests/` dir, you'll have several choices for how to launch and debug tests:

    - The `Run Tests` button should be visible in the status bar.
    - Above each test method and test class in Python files you open in VS Code, you should see the `Run Test | Debug Test` adornments.
    - In the VS Code Activity Bar, you should see the `Test` button, which opens the test explorer, which supports running and debugging tests.

1. Open `tests/test_sample.py` in VS Code
1. To debug the test in that file, set a breakpoint in the `test_one` method and click `Debug Test`.
1. To see the desktop of the `selenium-server` container (so you can watch or interact with the browser being controlled by the `selenium-client` container):
    - Use a VNC client to connect to `localhost:5900` (the VNC port published to your host by the `selenium-server` container)
    - Use password `password`
    - Note you can launch the built-in macOS VNC client from the command line, with:
        - `open vnc://localhost:5900`
