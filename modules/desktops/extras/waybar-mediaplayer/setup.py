from setuptools import setup, find_packages

setup(
    name="mediaplayer",
    version="0.1.0",
    description="A media player manager using Playerctl",
    author="Simon Antonius Lauer",
    author_email="simon.lauer@posteo.de",
    packages=find_packages(),
    install_requires=[],
    entry_points={
        "console_scripts": [
            "mediaplayer = mediaplayer.player:main",
        ],
    },
    python_requires=">=3.6",
)
