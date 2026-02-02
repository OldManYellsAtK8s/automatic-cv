FROM pandoc/latex:latest

WORKDIR /workspace
COPY . .

RUN mkdir -p /output

CMD ["/bin/sh", "-c", "DATE=$(date +'%Y-%m-%d'); pandoc docs/CV.md -o /output/Craig-Simpson-CV-${DATE}.pdf --pdf-engine=pdflatex --variable geometry:margin=1in --metadata title='Craig Simpson CV' --metadata date='${DATE}'"]
