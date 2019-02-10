#!/usr/bin/env python3

import argparse
import json
import sys

from jsonmerge import Merger

def main(args=None):
    parser = argparse.ArgumentParser()
    parser.add_argument('base', type=argparse.FileType('r', encoding='utf_8'),
                        help='the document we are merging changes into')
    parser.add_argument('head', type=argparse.FileType('r', encoding='utf_8'),
                        help='changed document')
    parser.add_argument('schema', nargs='?', type=argparse.FileType('r', encoding='utf_8'),
                        default='fresh-resume-schema/schema/fresh-resume-schema_1.0.0-beta.json',
                        help='JSON schema that defines merge strategies')

    namespace = parser.parse_args(args)

    schema = {}
    if namespace.schema is not None:
        schema = json.load(namespace.schema)
    merger = Merger(schema)
    result = merger.merge(json.load(namespace.base), json.load(namespace.head))
    json.dump(result, sys.stdout)
    sys.stdout.write('\n')

    namespace.base.close()
    namespace.head.close()

    sys.exit(0)

if __name__ == '__main__':
    main()
