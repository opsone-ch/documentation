FROM python:3-slim

RUN pip install Sphinx==3.0.0b1
RUN pip install sphinx_rtd_theme
RUN pip install sphinx-autobuild
RUN pip install Jinja2==3.0.3

EXPOSE 8080

CMD sphinx-autobuild /tmp/docs /tmp/build --host 0.0.0.0 --port 8080 -aEW -j 4
