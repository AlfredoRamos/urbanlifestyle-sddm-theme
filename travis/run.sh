#!/bin/bash --

# Run QML Lint
qmllint $(find . -maxdepth 2 -type f -path '*.qml' | xargs)
