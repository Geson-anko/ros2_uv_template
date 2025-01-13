from ros2_uv_template.subscriber_member_function import MinimalSubscriber


def test_subscriber_creation(rclpy_init):
    publisher = MinimalSubscriber()
    assert publisher.get_name() == "minimal_subscriber"
