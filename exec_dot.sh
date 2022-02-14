#!/usr/bin/env bash

[ -x dot ] && echo "Command dot not found" >&2 && exit 1

dot -Tpng imgs/XD.dot > imgs/XicotliDataSchema.png
