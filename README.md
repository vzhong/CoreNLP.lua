# CoreNLP.lua
Lua client for Stanford CoreNLP

## Usage

First, start the [CoreNLP server](http://stanfordnlp.github.io/CoreNLP/):

```bash
java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer
```

Next, you can use the Lua client in your program:

```lua
local CoreNLP = require 'corenlp'

local c = CoreNLP()  -- you can optionally give as parameter the url to the CoreNLP server.

-- the first argument is the document, the second argument is the properties field described here: http://stanfordnlp.github.io/CoreNLP/corenlp-server.html
local got = c:parse('the quick brown fox jumped over the lazy dog', {["tokenize.whitespace"] = true, annotators = "tokenize,ssplit,ner"})

print(got)
```
