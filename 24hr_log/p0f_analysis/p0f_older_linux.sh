#!/bin/bash
p0f -r $1 | grep 'Linux 2' -B4 -A6
