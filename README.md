# udpipe-server-baltic-sea
UDPipe REST server Docker image with language models of Baltic Sea coastal states.

## Introduction

Dockerfile builds UDPipe REST server with language models for Baltic Sea coastal states.

Coastal states are: [Denmark](https://en.wikipedia.org/wiki/Denmark), [Estonia](https://en.wikipedia.org/wiki/Estonia), [Finland](https://en.wikipedia.org/wiki/Finland), [Germany](https://en.wikipedia.org/wiki/Germany), [Latvia](https://en.wikipedia.org/wiki/Latvia), [Lithuania](https://en.wikipedia.org/wiki/Lithuania), [Poland](https://en.wikipedia.org/wiki/Poland), [Russia](https://en.wikipedia.org/wiki/Russia), [Sweden](https://en.wikipedia.org/wiki/Sweden).

All training files are from [Universal Dependencies](https://github.com/UniversalDependencies/).

All language models have trained using instructions in [udpipe-rest-server-docker](https://github.com/samisalkosuo/udpipe-rest-server-docker) repository.

Model filenames indicate the date when the model was trained.

## Docker image

There is Docker image available from DockerHub.

Pull image:

- docker pull kazhar/udpipe-server-baltic-sea

Start image

- docker run -d --restart always -p 0.0.0.0:8080:8080 kazhar/udpipe-server-baltic-sea

Or, clone this repo and build your own image

- docker build -t udpipe-server-baltic-sea .

## Using REST server API

See [UDPipe REST API docs](http://lindat.mff.cuni.cz/services/udpipe/api-reference.php).

In short, after you have Docker image running in localhost:

- Get a list of available models: [http://127.0.0.1:8080/models](http://127.0.0.1:8080/models).
- Parse Finnish text: [http://127.0.0.1:8080/process?data=Hei%20maailma!Mit%C3%A4%20kuuluu?&tokenizer&tagger&parser&model=fi](http://127.0.0.1:8080/process?data=Hei%20maailma!Mit%C3%A4%20kuuluu?&tokenizer&tagger&parser&model=fi).
- Parse Swedish text: [http://127.0.0.1:8080/process?data=Sverige%20är%20en%20konstitutionell%20monarki%20med%20parlamentarisk%20demokrati%20och%20utvecklad%20ekonomi.&tokenizer&tagger&parser&model=sv](http://127.0.0.1:8080/process?data=Sverige%20är%20en%20konstitutionell%20monarki%20med%20parlamentarisk%20demokrati%20och%20utvecklad%20ekonomi.&tokenizer&tagger&parser&model=sv).
- and so on.

You can use curl too:

- curl -F data=@data/finnish.txt -F model=fi -F tokenizer= -F tagger= -F parser= http://127.0.0.1:8080/process
- curl -F data=@data/swedish.txt -F model=sv -F tokenizer= -F tagger= -F parser= http://127.0.0.1:8080/process

And to get CoNLL-U format from curl-call:

- curl -F data=@data/swedish.txt -F model=sv -F tokenizer= -F tagger= -F parser= http://127.0.0.1:8080/process | PYTHONIOENCODING=utf-8 python -c "import sys,json; sys.stdout.write(json.load(sys.stdin)['result'])"
- Or use [scripts/get_conllu.sh](scripts/get_conllu.sh)
  - *./scripts/get_conllu.sh fi data/finnish.txt*


## Disclaimer

Everything in this repo, including all code is "AS IS". No support, no warranty, no fitness for any purpose, nothing is expressed or implied, not by me (nor my employer).

## License

I am not sure what license to apply, so I don't claim any licensing.

If you want to know more and be sure, please seek legal advice.
