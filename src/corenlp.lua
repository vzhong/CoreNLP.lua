--[[ Lua implementation of CoreNLP client. ]]
local json = require 'cjson'
local sh = require 'corenlp.sh'
local class = require 'class'

local CoreNLP = class('CoreNLP')

--[[ Constructor.
`url` is the url at which the CoreNLP server listens. Make sure your CoreNLP server is running:

```
java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer
```
]]
function CoreNLP:__init(url)
  url = url or 'http://localhost:9000'
  self.url = url
end

function CoreNLP:parse_opt(opt)
  local s = ''
  for k, v in pairs(opt) do
    s = s .. '"' .. k .. '"' .. ': ' .. '"' .. tostring(v) .. '", '
  end
  return s
end

function CoreNLP:parse(raw, opt)
  opt = opt or {annotators = "tokenize,ssplit"}
  local query = [[-q --post-data ']] .. raw .. [[' ']]
  query = query .. self.url .. [[/?properties={]] .. self:parse_opt(opt) .. [["outputFormat": "json"}' -O -]]
  if opt.verbose then
    print('wget '..query)
  end
  local result = wget(query)
  return json.decode(tostring(result))
end

return CoreNLP