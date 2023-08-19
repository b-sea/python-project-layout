from setuptools import setup, find_packages


setup(
    name='python-project',
    description='',
    use_scm_version=True,
    include_package_data=True,
    packages=find_packages('src'),
    package_dir={'': 'src'},
    setup_requires=['setuptools_scm'],
    install_requires=[]
)
