#Parser class defined in parser.rb

require 'symbolTable.rb'

#Parses through .asm code
class Parser
    #Initialize the parser object, puts the input file into an array
    def initialize(inputFile)
        #Array that will contain the command code
        @commandArray = Array.new
        addToArray(inputFile)
        #Current command on specified line
        @location = 0
        @currentCommand = @commandArray[@location]
        @table = SymbolTable.new
        firstPass()
    end

    #Looks through the lines, removes white space, and adds the command if it is not a comment or empty line
    def addToArray(fileInput)
        i = 0
        loc = 0
        file = File.new(fileInput, "r")
        while (line = file.gets)
            line = line.gsub(/[[:space:]]+/, '')
            if ((line.slice(0) != "/") and (line.empty? != true)) 
                @commandArray.insert(loc, line)
                loc += 1
            end
            i += 1
        end
        file.close
    end

    #Prints the current command array (Used for testing)
    def printArray
        i = 0
        while (i < (@commandArray.length + 1))
            puts @commandArray.at(i)
            i += 1
        end
    end

    #Checks if there are more commands left to analyze
    def hasMoreCommands
        result = true
        if ((@location + 1) > @commandArray.length)
            result = false
        end
    return result
    end

    #Changes the current line of commands at a new location (location += 1)
    def advance
        #Check for current instance of location
        @location += 1
        @currentCommand = @commandArray.at(@location)
    end

    #determines what type of command the current line of code is *Add symbol commands later
    def commandType
        result = ""
        if (@currentCommand.slice(0) == "@")
            result = "A_COMMAND"
        elsif (@currentCommand.slice(0) == '(')
            result = "L_COMMAND"
        else
            result = "C_COMMAND"
        end
    return result
    end

    #Returns the numerical value for an A_COMMAND
    def symbol
        i = 1
        sym = ""
        nums = Array['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', "-"]

        if (nums.include?(@currentCommand.slice(i)))
            while ((i < @currentCommand.length) and (@currentCommand.slice(i) != '/'))
                if (nums.include?(@currentCommand.slice(i)))
                    sym += @currentCommand.slice(i)
                else
                    raise "Invalid input"
                end
                i += 1
            end
        else
            while ((i < @currentCommand.length) and (@currentCommand.slice(i) != '/'))
                sym += @currentCommand.slice(i)
                i += 1
            end

            if (@table.contains(sym) == false)
                @table.addRAMEntry(sym)
            end
            sym = @table.GetAddress(sym)
        end
    return sym
    end

    #Returns the dest mnemonic of a C command
    def dest
        if (@currentCommand.include?'=')
            result = ""
            if (@currentCommand.slice(0) == "0")
                result = "null"
            else
                endmarks = Array['=', ';']
                i = 0

                while (endmarks.include?(@currentCommand.slice(i)) != true)
                    result += @currentCommand.slice(i)
                    i += 1
                end
            end
        else
            result = 'null'
        end
    return result
    end

    #Function that iterates through the code and finds ROM addresses
    def firstPass
        currentLocation = @location
        while (@location < @commandArray.length)
            @currentCommand = @commandArray[@location]
            
            if (@currentCommand.slice(0) == '(')
                sym = ''
                i = 1

                while (@currentCommand.slice(i) != ')')
                    sym += @currentCommand.slice(i)
                    i += 1
                end
                @table.addROMEntry(sym, currentLocation)
            else
                currentLocation += 1
            end
            @location += 1
        end

        @location = 0
        @currentCommand = @commandArray[@location]
    end

    #Returns the comp mnemonic of a C command
    def comp
        result = ""
        i = 0

        while ((i < @currentCommand.length and @currentCommand.slice(i) != '/') and 
            (@currentCommand.slice(i) != "=" and @currentCommand.slice(i) != ";"))
            i += 1
        end

        if (@currentCommand.slice(i) == "=")
            i += 1

            while ((i < @currentCommand.length) and (@currentCommand.slice(i) != ";" and @currentCommand.slice(i) != '/'))
                result += @currentCommand.slice(i)
                i += 1
            end
        elsif (@currentCommand.slice(i) == ";")
            i = 0

            while ((i < @currentCommand.length) and (@currentCommand.slice(i) != ';'))
                result += @currentCommand.slice(i)
                i += 1
            end
        end
    return result
    end

    #Returns the jump mnemonic of a C command
    def jump
        result = ""
        i = 0

        while ((i < @currentCommand.length) and (@currentCommand.slice(i) != ";"))
            i += 1
        end

        if (@currentCommand.slice(i) == ";")
            i += 1

            while (i < @currentCommand.length and @currentCommand.slice(i) != '/')
                result += @currentCommand.slice(i)
                i += 1
            end
        else
            result = "null"
        end
    return result
    end
end
