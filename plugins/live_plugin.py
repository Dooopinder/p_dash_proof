def pytest_addoption(parser):
    parser.addoption("--live", action="store_true")

def pytest_configure(config):
    config._live_loaded = True
