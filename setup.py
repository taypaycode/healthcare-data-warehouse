from setuptools import setup, find_packages

setup(
    name='healthcare-data-warehouse',
    version='0.1',
    packages=find_packages(),
    install_requires=[
        'pandas>=2.2.3',
        'numpy>=2.1.2',
        'sqlalchemy>=1.4.46',
    ],
)