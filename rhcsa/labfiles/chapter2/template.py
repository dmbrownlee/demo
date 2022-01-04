#!/usr/bin/python3
import getopt
import sys


class Greeter:
  """The most amazing class ever."""
  name = "World"
  greeting = f"Hello, {name}!"
  def __init__(self, greeting=None, name=None):
    if greeting:
      self.greeting = greeting
    if name:
      self.name = name

  def run(self, name=None):
    if not name:
      name = self.name
    print(f"Hello {name}!")


def usage(rc=1, msg=None):
  if msg:
    print(msg)
  print(f"USAGE: {sys.argv[0]} [-h] [-n <name>]")
  sys.exit(rc)


def main():
  """ The main function is responsible for parsing command line options and
      arguments before instantiating the program's primary object and calling
      its run method."""
  try:
    opts, args = getopt.getopt(sys.argv[1:], "hn:")
  except getops.error as msg:
    usage(msg, 1)

  # Setting name to None uses Greeter;s default name
  name = None

  # changed default behavior based on options
  for o, a in opts:
    if o == '-h':
      usage(0)
    if o == '-n':
      name = a

  g = Greeter()
  g.run(name)


if __name__ == "__main__":
  main()
