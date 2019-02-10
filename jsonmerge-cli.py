#!/usr/bin/env python3

import argparse
import functools
import json
import sys

from jsonmerge import Merger

def main(args=None):
    parser = argparse.ArgumentParser()
    parser.add_argument('base', type=argparse.FileType('r', encoding='utf_8'),
                        help='the document we are merging changes into')
    parser.add_argument('head', nargs='+', type=argparse.FileType('r', encoding='utf_8'),
                        help='changed documents')
    parser.add_argument('--schema', type=argparse.FileType('r', encoding='utf_8'),
                        default='fresh-resume-schema/schema/fresh-resume-schema_1.0.0-beta.json',
                        help='JSON schema that defines merge strategies')

    namespace = parser.parse_args(args)

    schema = {}
    if namespace.schema is not None:
        schema = json.load(namespace.schema)
    merger = Merger(schema)
    result = functools.reduce(lambda x,y: merger.merge(x, json.load(y)), namespace.head, json.load(namespace.base))
    json.dump(result, sys.stdout)
    sys.stdout.write('\n')

    sys.exit(0)

if __name__ == '__main__':
    main()
