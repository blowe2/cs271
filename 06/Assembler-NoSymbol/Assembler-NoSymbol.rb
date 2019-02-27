$LOAD_PATH << '.'

require 'parser.rb'
require 'code.rb'

#Main driver for translation process
def main(assem)
    $machineCode = Array.new

    translate(assem)
    ontoNew(assem)
end

#translates the assembly language to machine language
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

#Puts the translated machine code onto a new file
def ontoNew(assem)
    fileName = assem.slice(0, assem.length-3) + "hack"
    output = File.new(fileName, 'w')
    loc = 0

    while (loc < $machineCode.length)
        output.puts($machineCode[loc])

        loc += 1
    end
    output.close
end

#Determines if argument received from command line is a .asm file
def checkForASM
    i = 0
    sym = ''

    while (i <= 4)
        sym += ARGV[0].slice((ARGV[0].length - 5) + i)
        i += 1
    end

    if (sym == '.asm')
        main(ARGV[0])
    else
        raise "Must receive a .asm file as an argument"
    end
end

#Determines if an argument was received from the command line
if (ARGV[0] == nil)
    raise "Must recieve a .asm as an argument"
else
    checkForASM()
end