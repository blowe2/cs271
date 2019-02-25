$LOAD_PATH << '.'

require 'parser.rb'
require 'code.rb'

def main(assem)
    $machineCode = Array.new

    translate(assem)
    ontoNew(assem)
end

def translate(assem)
    parsingObject = Parser.new(assem)
    codeObject = Code.new
    loc = 0

    while (parsingObject.hasMoreCommands)
        if (parsingObject.commandType == 'A_COMMAND')
            $machineCode[loc] = codeObject.toBinary(parsingObject.symbol.to_i)
        elsif (parsingObject.commandType == 'C_COMMAND')
            $machineCode[loc] = "111" + codeObject.comp(parsingObject.comp) + codeObject.dest(parsingObject.dest) + 
                codeObject.jump(parsingObject.jump)
        end
        parsingObject.advance
        loc += 1
    end
end

def ontoNew(assem)
    fileName = assem.slice(0, assem.length-3)
    output = File.new(fileName, 'w')
    loc = 0

    while (loc < $machineCode.length)
        output.puts($machineCode[loc])

        loc += 1
    end
    output.close
end

main(ARGV[0])