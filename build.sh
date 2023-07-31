#!/bin/bash

cd hello-world-app
dotnet restore
dotnet rpm -c Release -o ../
