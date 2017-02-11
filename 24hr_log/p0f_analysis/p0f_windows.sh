#!/bin/bash
p0f -r $1 | grep 'Windows' -B4 -A6
