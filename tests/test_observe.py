def test_plugins(pytestconfig):
    print("live loaded:", getattr(pytestconfig, "_live_loaded", False))
    assert True
