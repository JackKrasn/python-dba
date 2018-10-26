#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import yaml


def get_sql(sql_dir, filename):
    with open(os.path.join(sql_dir, filename)) as f:
        return tuple(s.strip() for s in f.read().rstrip().rstrip(';').split(';'))


def load_yml_config(file_name):
    with open(file_name, 'r') as stream:
        try:
            return yaml.load(stream)
        except yaml.YAMLError as exc:
            return exc

