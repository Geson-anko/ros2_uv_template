from ros2_uv_template.publisher_member_function import MinimalPublisher


def test_publisher_creation(rclpy_init):
    publisher = MinimalPublisher()
    assert publisher.get_name() == "minimal_publisher"
