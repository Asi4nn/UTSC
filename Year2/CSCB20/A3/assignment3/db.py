from os.path import isfile, dirname, abspath, join
from sqlite3 import connect
from datetime import datetime


BASE_DIR = dirname(abspath(__file__))
BUILD_PATH = join(BASE_DIR, "build.sql")
DB_PATH = join(BASE_DIR, "assignment3.db")
if not isfile(DB_PATH):
    raise FileNotFoundError("assignment3.db not found")
if not isfile(BUILD_PATH):
    raise FileNotFoundError("build.sql not found")


cxn = connect(DB_PATH, check_same_thread=False)
cur = cxn.cursor()


def with_commit(func):
    def inner(*args, **kwargs):
        func(*args, **kwargs)
        commit()

    return inner


@with_commit
def build():
    time = datetime.now().strftime("[%H:%M:%S]")
    print(time, "Building Database")
    if isfile(BUILD_PATH):
        scriptexec(BUILD_PATH)


def scriptexec(path):
    with open(path, 'r', encoding='utf-8') as script:
        cur.executescript(script.read())


def commit():
    time = datetime.now().strftime("[%H:%M:%S]")
    print(time, "Saving to Database")
    cxn.commit()


def close():
    cxn.close()

# Use these functions by using "?" as placeholder and pass in the values for *values
# Example: execute("INSERT INTO Table1(value1, value2) VALUES (?, ?)", value1, value2)


def field(command, *values):
    cur.execute(command, tuple(values))

    fetch = cur.fetchone()
    if fetch is not None:
        return fetch[0]


def record(command, *values):
    cur.execute(command, tuple(values))

    return cur.fetchone()


def records(commands, *values):
    cur.execute(commands, tuple(values))

    return cur.fetchall()


def column(command, *values):
    cur.execute(command, *values)

    return [item[0] for item in cur.fetchall()]


def execute(command, *values):
    cur.execute(command, tuple(values))

