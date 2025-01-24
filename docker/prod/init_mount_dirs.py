#!/usr/bin/env python
"""
Init dirs for bind volumes expected docker environment in a general case,
run with user that will run docker service
"""
from pathlib import Path


# Case for run at root of project
# BASE_DIR: Path = Path(__file__).resolve().parent

# Case for run at docker/up_type
BASE_DIR: Path = Path(__file__).resolve().parent.parent.parent

DIR_MODE = 0o777
FILE_MODE = 0o666

# Docker compose location, example case docker/prod
COMPOSE_DIR: Path = Path(
    BASE_DIR,
    "docker",
    "prod",
)

ROOT_MOUNT_DIR = Path(
    BASE_DIR,
    "mount",
)

# folders list
MOUNT_LIST = (
    "db",
    "redis-tasks",
    "foreman_gems",
)

for app_i in MOUNT_LIST:
    Path(ROOT_MOUNT_DIR, app_i).mkdir(
        parents=True,
        exist_ok=True,
    )
