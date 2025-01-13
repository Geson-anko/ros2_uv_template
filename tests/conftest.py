from collections.abc import Generator

import pytest
import rclpy


@pytest.fixture(scope="session")  # Using this fixture in all test session.
def rclpy_init() -> Generator[None, None, None]:
    rclpy.init()
    yield
    rclpy.shutdown()
