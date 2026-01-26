def test_started(pytestconfig):
    print("live loaded:", getattr(pytestconfig, "_live_loaded", False))
    assert True

def test_loaded(pytestconfig):
    assert getattr(pytestconfig, "_live_loaded", False)
