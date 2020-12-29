FROM python:3-slim

RUN pip install Sphinx==3.0.0b1
RUN pip install sphinx_rtd_theme

EXPOSE 80

CMD sphinx-build /tmp/docs /tmp/build -aEW -j 4 \
    && python3 -m http.server 80 --directory /tmp/build
