#!/bin/sh

echo "Running .NET worker app ..."
dotnet /opt/devops/voting-system/worker-master/out/Worker.dll
