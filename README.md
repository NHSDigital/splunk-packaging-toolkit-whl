
# splunk-packaging-toolkit-whl

usage:

```shell
make install
make dist
```

this is just a helper for packaging the splunk-packaging-toolkit==1.0.1 https://pypi.org/project/splunk-packaging-toolkit as whl

the current install is tar.gz and attempts to create a symlink in /usr/share and isn't aware of virtualenvs
